ActiveAdmin.register BusesAttendee do
  permit_params BusesAttendee.column_names.map(&:to_sym)
end
