class ImportsController < ApplicationController
  include ImportCompanies

  def companies_from_xlsx
    if params[:file] && params[:file].tempfile
      ImportCompanies.parse_and_import(params[:file].tempfile)
    end
    redirect_to admin_import_companies_path
  end

end
