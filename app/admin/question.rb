ActiveAdmin.register Question do
  permit_params Question.column_names.map(&:to_sym)
end
