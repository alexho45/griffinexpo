ActiveAdmin.register Attendee do

  permit_params Attendee.column_names.map(&:to_sym)

  index do
    selectable_column
    Attendee.column_names.each do |c|
      column c.to_sym
    end
    actions
  end

end
