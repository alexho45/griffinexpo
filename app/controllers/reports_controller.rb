class ReportsController < ApplicationController

  def companies
    @companies =
      if params[:event_id].present? && params[:company_type].present?
        Event
          .find(params[:event_id])
          .companies
          .send(params[:company_type])
      else
        []
      end

    respond_to do |format|
      format.js do
        html = render_to_string(
            partial:    "#{params[:company_type]}_companies",
            locals:     { companies: @companies,
                          path:      params[:path].presence }
        )

        render json: {
            success: true,
            html:    html
        }
      end
      format.csv do
        headers['Content-Type'] ||= 'text/csv'
        render template: "reports/#{params[:company_type]}_companies"
      end
    end
  end

end
