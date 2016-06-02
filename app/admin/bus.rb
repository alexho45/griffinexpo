ActiveAdmin.register Bus do

  permit_params Bus.column_names.map(&:to_sym)

end
