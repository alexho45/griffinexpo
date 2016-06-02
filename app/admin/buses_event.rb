ActiveAdmin.register BusesEvent do
  permit_params BusesEvent.column_names.map(&:to_sym)
end
