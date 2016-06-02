ActiveAdmin.register Package do
  permit_params Package.column_names.map(&:to_sym)
end
