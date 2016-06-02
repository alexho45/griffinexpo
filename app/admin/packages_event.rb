ActiveAdmin.register PackagesEvent do
  permit_params PackagesEvent.column_names.map(&:to_sym)
end
