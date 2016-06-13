class CheckinsController < ApplicationController

  def update_attendees
    if params[:event_id].present?
      attendees_to_add = Attendee.where(id: params[:attendees].map{|k,v| k if v == "on" })
      attendees_to_remove = Attendee.where(id: params[:attendees].map{|k,v| k if !v.present? })
      event = Event.find(params[:event_id])
      event.checked_attendees = event.checked_attendees + attendees_to_add - attendees_to_remove
    end
    redirect_to admin_checkins_path(event_id: params[:event_id], company_id: params[:company_id])
  end

  def download_event_attendees
    set_attendees
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
                  disposition: 'attachment')
      end
    end
  end

  def print_bagdes
    set_attendees
    html = render_to_string(template: "admin/badges", 
                            locals: { badges: badges(@attendees) })
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,
              disposition: 'attachment')
  end

  def set_attendees
    @attendees = Attendee
                  .includes(:company)
                  .where(id: params[:attendees]
                  .split(','))
    @checked_attendees = if params[:event_id].present?
                          Event.find(params[:event_id]).checked_attendees
                        else
                          []
                        end
  end

  def badges(attendees)
    attendees.map do |attendee|
      company = attendee.company
      url = admin_register_url(attendee_id: attendee.id)
      qr = RQRCode::QRCode.new(url)
      puts url
      {
        name: attendee.full_name.upcase,
        company_name: company.try(:name).try(:upcase),
        company_location: company.try(:location).try(:upcase),
        company_cust: company.try(:account_number),
        company_warehouse: company.try(:warehouse),
        qr: qr
      }
    end
  end

end
