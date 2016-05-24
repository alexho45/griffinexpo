class CompaniesController < ApplicationController
  before_action :find_company

  def new_registration
    session[:company_access_token] = nil
    redirect_to root_path
  end

  def in_process
    puts "IN PROCESS session: #{session[:company_access_token]}"


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
      @company.set_step(:company_info)
      Question.generate_standard_questions(@company)
    end
    redirect_to in_process_companies_path
  end

  def save_info_and_attendees
    if @company.update_attributes(company_params)
      @company.event.attendees << @company.attendees
      step = @company.vendor? ? :select_packages : :questions
      @company.set_step(step)
    end
    redirect_to in_process_companies_path
  end

  def select_accommodations
    if params[:step_back].present?
      @company.set_step(:packages_order_verification)
    else
      @company.apply_payment(company_params[:payment_type])
      @company.set_step(:select_accommodations)
    end
    redirect_to in_process_companies_path
  end

  def verification
    if params[:step_back].present?
      @company.set_step(:select_payment_type)
    else
      @company.hotels_events.destroy_all
      create_hotels_events
      @company.set_step(:verification)
    end
    redirect_to in_process_companies_path
  end

  def confirmation
    if params[:step_back].present?
      @company.set_step(:select_accommodations)
    else
      @company.complete_registration
    end
    redirect_to in_process_companies_path
  end

  # Vendor actions

  def select_packages
    @company.packages_events.destroy_all
    create_packages_events
    @company.set_step(:packages_order_verification)
    redirect_to in_process_companies_path
  end

  def select_payment_type
    if params[:step_back].present?
      @company.set_step(:select_packages)
    else
      @company.set_step(:select_payment_type)
    end
    redirect_to in_process_companies_path
  end

  # Customer actions

  def questions
    redirect_to in_process_companies_path
  end

  private
    def find_company
      @company =
        if session[:company_access_token].present? && Company.exists?(access_token: session[:company_access_token])
          Company
            .includes(:event ,:attendees, :packages, :hotels)
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
