ActiveAdmin.register_page "Checkins" do

  content do
    render :template => 'admin/checkins'
  end

  controller do
    def index
      @event =  if params[:event_id].present?
                  Event
                    .includes(:companies, :checked_attendees)
                    .find(params[:event_id])
                end
      @company =  if params[:company_id].present?
                    Company.find(params[:company_id])
                  end
      @event_companies = @event.try(:companies).try(:confirmation) || [] 
      @attendees =  if @event && @company
                      @event
                        .attendees
                        .includes(:company)
                        .select {|att| att.company == @company if @company }
                    elsif !@company
                      @event
                        .try(:attendees)
                        .try(:includes, :company) || []
                    else
                      []
                    end
      @checked_attendees = @event.try(:checked_attendees) || []
    end
  end


end
