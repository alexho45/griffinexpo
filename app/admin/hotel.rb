ActiveAdmin.register Hotel do
  permit_params Hotel.column_names.map(&:to_sym)
end
