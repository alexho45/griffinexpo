class CompaniesController < ApplicationController
  before_action :find_company

  # Common actions

  def new_registration
    session.delete(:company_access_token)
    session.delete(:accomodations_answer_checked)
    session.delete(:are_you_currently_a_customer)
    session.delete(:accomodations_answer_checked)
    redirect_to root_path
  end

  def in_process
  end

  def select_type
    @company = Company.new(company_params)

    if @company.save
      session[:company_access_token] = @company.access_token
      session[:accomodations_answer_checked] = true
    end
    redirect_to in_process_companies_path
  end

  def select_event
    event = Event.find(params[:event_id]) if params[:event_id].present?
    if event
      @company.event = event
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  def save_info_and_attendees
    if @company.update_attributes(company_params)
      update_company_session_attributes
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  # Vendor custom actions

  def select_packages
    if params[:step_back].present?
      @company.previous_step
    else
      create_packages_events
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  def select_payment_type
    if params[:step_back].present?
      @company.previous_step
    else
      @company.next_step      
    end
    redirect_to in_process_companies_path
  end

  # Customer custom actions

  def questions
    if params[:step_back].present?
      @company.previous_step
    else
      create_companies_answers
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  def select_buses
    if params[:step_back].present?
      @company.previous_step
    else
      create_buses_events
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  # End of custom actions

  def select_accommodations
    if params[:step_back].present?
      @company.previous_step
    else
      @company.apply_payment(company_params[:payment_type])
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  def verification
    if params[:step_back].present?
      @company.previous_step
    else
      create_hotels_events
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  def confirmation
    if params[:step_back].present?
      @company.previous_step
    else
      @company.complete_registration
    end
    redirect_to in_process_companies_path
  end

  # End of actions

  def search
    companies = []
    if params[:term].present?
      select_attributes = %w(
        account_number, warehouse,
        name, registrant, representative_email, representative_phone,
        address, zip_code, us_state, city
      ).join
      companies = Company
                    .select(select_attributes)
                    .send(@company.company_type)
                    .where("lower(name) LIKE ?", "%#{params[:term].downcase}%")
                    .first(10)
    end
    render json: companies
  end

  private
    def find_company
      @company =
        if session[:company_access_token].present? && Company.exists?(access_token: session[:company_access_token])
          Company
            .includes(:event ,:attendees, :packages, :hotels, :answers)
            .find_by(access_token: session[:company_access_token])
        else
          Company.new
        end
    end

    def update_company_session_attributes
      if !params[:are_you_currently_a_customer].present? || params[:are_you_currently_a_customer] == "0"
        session[:are_you_currently_a_customer] = false
        @company.update_attribute(:account_number, 9999)
      else
        session[:are_you_currently_a_customer] = true
      end

      if !params[:i_am_also_an_attendee].present? || params[:i_am_also_an_attendee] == "0"
        session[:i_am_also_an_attendee] = false
      else
        session[:i_am_also_an_attendee] = true
      end
    end

    def create_packages_events
      @company.packages_events.destroy_all
      params[:packages].each do |package|
        if package.second["checked"]
          package_id = package.first
          PackagesEvent.create(package_id:  package_id,
                               company_id:  @company.id,
                               event_id:    @company.event.id,
                               quantity:    package.second["quantity"],
                               electricity: package.second["electricity"].to_i == 1)
        end
      end
    end

    def create_hotels_events
      @company.hotels_events.destroy_all
      params[:hotels].each do |hotel|
        if hotel.second["checked"] == 'true'
          hotel_id = hotel.first
          HotelsEvent.create(hotel_id:    hotel_id,
                             company_id:  @company.id,
                             event_id:    @company.event.id,
                             quantity:    hotel.second["quantity"])
        end
      end
      session[:accomodations_answer_checked] = HotelsEvent.where(company_id: @company.id).any?
    end

    def create_companies_answers
      @company.companies_answers.destroy_all
      params[:questions].each do |question, values|
        question_id = question
        values.each do |attendee_id, answer_id|
          CompaniesAnswer.create(question_id: question_id,
                                 answer_id:   answer_id,
                                 company_id:  @company.id,
                                 attendee_id: attendee_id)
        end
      end
      params[:questions_with_text] = params[:questions_with_text] || {}
      params[:questions_seminars] = params[:questions_seminars] || {}
      (params[:questions_with_text].merge(params[:questions_seminars])).each do |question, values|
        question_id = question
        values.each do |attendee_id, answer_value|
          answer = Answer.create(value:       answer_value)
          CompaniesAnswer.create(question_id: question_id,
                                 answer_id:   answer.id,
                                 company_id:  @company.id,
                                 attendee_id: attendee_id)
        end
      end
    end

    def create_buses_events
      @company.event.buses.each do |bus|
        bus.attendees.destroy_all
      end
      if params[:checked_buses].present? && params[:checked_buses] == "true"
        attendees = @company.attendees.dup
        params[:buses].each do |bus|
          bus = Bus.find(bus.first.to_i)
          if attendees.count > bus.available_seats
            attendees_to_bus = attendees.first(bus.available_seats).dup
            attendees -= attendees_to_bus
          else
            attendees_to_bus = attendees.dup
            attendees -= attendees_to_bus
          end
          bus.attendees << attendees_to_bus
        end
      end
    end

    def company_params
      params
        .require(:company)
        .permit(:name, :registrant, :address, :representative_email, :zip_code, :us_state, :city,
                :representative_phone, :company_type, :access_token, :payment_status,
                :payment_type, :confirmation_token, :process_step, :account_number, :warehouse,
                attendees_attributes: [:id, :first_name, :last_name,
                                       :email, :phone, :company_id, :_destroy])
    end
end
