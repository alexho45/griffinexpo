ActiveAdmin.register_page "Checkins" do

  content do
    render :template => 'admin/checkins'
  end

  controller do
    def index
      @event = if params[:event_id]
                 Event.find(params[:event_id])
               end
      @attendees = @event.try(:attendees) || []
      @checked_attendees = @event.try(:checked_attendees) || []
    end
  end


end
