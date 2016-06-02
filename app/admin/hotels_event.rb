ActiveAdmin.register HotelsEvent do
  permit_params HotelsEvent.column_names.map(&:to_sym)
end
