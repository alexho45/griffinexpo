class ImportsController < ApplicationController

  def companies_from_xlsx
    if params[:file] && params[:file].tempfile
      companies = Company.all
      xlsx = Roo::Excelx.new(params[:file].tempfile)
      sheet = xlsx.sheet(0)
      sheet.each(warehouse:      'Whse',
                 account_number: 'Cust #',
                 company_name:   'Description',
                 company_email:  'Email Address') do |hash|
        company = companies
                    .select{|c| c.name && c.name.downcase == hash[:company_name].try(:downcase) }
                    .first
        if company
          company.update_attribute(:warehouse, hash[:warehouse])
          company.update_attribute(:account_number, hash[:account_number])
        end
      end
    end
    redirect_to admin_import_companies_path
  end

end
