class CompaniesController < ApplicationController
  before_action :find_company

  # Common actions

  def new_registration
    session.delete(:company_access_token)
    redirect_to root_path
  end

  def in_process
  end

  def select_type
    @company = Company.new(company_params)

    if @company.save
      session[:company_access_token] = @company.access_token
    end
    redirect_to in_process_companies_path
  end

  def select_event
    event = Event.find(params[:event_id]) if params[:event_id].present?
    if event
      @company.event = event
      @company.next_step
      Question.generate_standard_questions(@company)
    end
    redirect_to in_process_companies_path
  end

  def save_info_and_attendees
    if @company.update_attributes(company_params)
      @company.event.attendees << @company.attendees
      @company.next_step
    end
    redirect_to in_process_companies_path
  end

  # Vendor custom actions

  def select_packages
    @company.packages_events.destroy_all
    create_packages_events
    @company.next_step
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
    @company.companies_answers.destroy_all
    create_companies_answers
    @company.next_step
    redirect_to in_process_companies_path
  end

  def select_buses
    # @company.companies_buses.destroy_all
    # create_companies_buses
    if params[:step_back].present?
      @company.previous_step
    else
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
      @company.hotels_events.destroy_all
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

    def create_packages_events
      params[:packages].each do |packages|
        if packages.second["checked"]
          package_id = packages.first
          PackagesEvent.create(package_id:  package_id,
                               company_id:  @company.id,
                               event_id:    @company.event.id,
                               quantity:    packages.second["quantity"],
                               electricity: packages.second["electricity"].to_i == 1)
        end
      end
    end

    def create_hotels_events
      params[:hotels].each do |hotels|
        if hotels.second["checked"] == 'true'
          hotel_id = hotels.first
          HotelsEvent.create(hotel_id:    hotel_id,
                             company_id:  @company.id,
                             event_id:    @company.event.id,
                             quantity:    hotels.second["quantity"])
        end
      end
    end

    def create_companies_answers

    end

    def create_companies_buses

    end

    def company_params
      params
        .require(:company)
        .permit(:name, :registrant, :address, :representative_email,
                :representative_phone, :company_type, :access_token, :payment_status,
                :payment_type, :confirmation_token, :process_step,
                attendees_attributes: [:id, :first_name, :last_name,
                                       :email, :phone, :company_id, :_destroy])
    end
end
