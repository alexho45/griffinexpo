ActiveAdmin.register Answer do
  permit_params Answer.column_names.map(&:to_sym)
end
