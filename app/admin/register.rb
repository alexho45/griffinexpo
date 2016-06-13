ActiveAdmin.register_page "Register" do

  menu false

  content do
    render :template => 'admin/register'
  end

  controller do
    def index
      @attendee = nil
      if params[:attendee_id].present?
        @attendee = Attendee.find(params[:attendee_id])
        @event = @attendee.event
        if params[:seminar].present?
          CheckIn.find_or_create_by(
            event_id:    @event.id,
            attendee_id: @attendee.id,
            seminar:     params[:seminar]
          )
        else
          if @attendee.event.checked_attendees.exclude?(@attendee)
            @event.checked_attendees << @attendee
          end
        end
      end
    end
  end

end
