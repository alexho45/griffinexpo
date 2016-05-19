class CompaniesController < ApplicationController
  before_action :find_company

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
      @company.events << event
      @company.update_attribute(:process_step, :company_info)
    end
    redirect_to in_process_companies_path
  end


  private
    def find_company
      @company =
        if session[:company_access_token].present? && Company.exists?(access_token: session[:company_access_token])
          Company.find_by(access_token: session[:company_access_token])
        else
          Company.new
        end
    end

    def company_params
      params
        .require(:company)
        .permit(:name, :registrant, :address,
                :representative_email, :representative_phone, :company_type,
                :access_token, :payment_status, :payment_type,
                :confirmation_token, :process_step)
    end
end
