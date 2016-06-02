ActiveAdmin.register Attendee do

  index do
    selectable_column
    additional_fields = ["company"]
    (Attendee.column_names + additional_fields).each do |c|
      column c.to_sym
    end
    actions
  end

end
