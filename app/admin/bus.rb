ActiveAdmin.register Bus do

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    panel "Attendees" do
      table_for bus.attendees do
        Attendee.column_names.each do |c|
          column c.to_sym
        end

        column "Actions" do |attendee|
          link_to('View', admin_attendee_path(attendee))
        end
      end
    end
  end

  unused_fields = ["id", "created_at", "updated_at"]

  form do |f|
    f.inputs "Bus" do
      (Bus.column_names - unused_fields).each do |c|
        f.input c.to_sym
      end
    end
    f.input :attendees, as: :check_boxes, collection: f.object.try(:event).try(:attendees)
    f.has_many :buses_event, heading: 'Event' do |buses_event|
      buses_event.input :event, collection: Event.all
    end

    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

end
