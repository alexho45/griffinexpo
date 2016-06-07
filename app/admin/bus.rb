ActiveAdmin.register Bus do
  permit_params Bus.column_names.map(&:to_sym),
                attendee_ids: []

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

  form do |f|
    f.inputs "Bus" do
      Bus.column_names.each do |c|
        f.input c.to_sym
      end
    end
    f.input :attendees, as: :check_boxes, collection: f.object.event.attendees
    actions
  end

end
