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
            partial:    "companies",
            locals:     { companies:    @companies,
                          path:         params[:path].presence,
                          company_type: params[:company_type].presence }
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
      format.pdf do
        html = render_to_string(template: "reports/#{params[:company_type]}_companies", 
                                locals: { companies: @companies})
        pdf = WickedPdf.new.pdf_from_string(html)
        send_data(pdf,
                  disposition: 'attachment') 
      end
    end
  end

  def bus_attendees
    @bus = if params[:bus_id].present?
             Bus.find(params[:bus_id])
           end

    respond_to do |format|
      format.csv do
        headers['Content-Type'] ||= 'text/csv'
        render template: "admin/bus_report"
      end
      format.pdf do
        html = render_to_string(template: "admin/bus_report", 
                                locals: { bus: @bus})
        pdf = WickedPdf.new.pdf_from_string(html)
        send_data(pdf,
                  filename: @bus.title,
                  disposition: 'attachment') 
      end
    end
  end

end
