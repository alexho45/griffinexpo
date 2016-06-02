ActiveAdmin.register CompaniesAnswer do
  permit_params CompaniesAnswer.column_names.map(&:to_sym)

  menu false
end
