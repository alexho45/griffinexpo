class CheckinsController < ApplicationController

  def update_attendees
    if params[:event_id].present? && params[:attendees].present? && params[:attendees].any?
      attendees = Attendee.where(id: params[:attendees])
      event = Event.find(params[:event_id])
      event.checked_attendees = attendees
    end
    redirect_to admin_checkins_path(event_id: params[:event_id])
  end

  def download_event_attendees
    @event = if params[:event_id]
               Event.find(params[:event_id])
             end
    @attendees = @event.try(:attendees) || []
    @checked_attendees = @event.try(:checked_attendees) || []

    respond_to do |format|
      format.csv do
        headers['Content-Type'] ||= 'text/csv'
        render template: "admin/_event_attendees",
               locals: { attendees:         @attendees,
                         checked_attendees: @checked_attendees }
      end
      format.pdf do
        html = render_to_string(template: "admin/event_attendees", 
                                locals: { attendees:         @attendees,
                                          checked_attendees: @checked_attendees })
        pdf = WickedPdf.new.pdf_from_string(html)
        send_data(pdf,
                  filename: @event.full_name,
                  disposition: 'attachment')
      end
    end
  end

  def print_bagdes
    event = if params[:event_id]
              Event.find(params[:event_id])
            end
    attendees = event.try(:attendees) || []
    badges = attendees.map do |attendee|
      company = attendee.company
      # qr_code_img = RQRCode::QRCode
                      # .new('<a href="google.com">asadasdasdassdadasdasdasdasdasdadasd</a>' + attendee.id.to_s, size: 10)
                      # .to_img
      # image_raw = Base64.strict_encode64(qr_code_img.to_string)
      qr = RQRCode::QRCode.new('https://google.com')
      { name: attendee.full_name, company_name: company.name, qr: qr}
    end
    html = render_to_string(template: "admin/badges", 
                            locals: { badges: badges })
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,
              filename: event.full_name,
              disposition: 'attachment')
  end

end
