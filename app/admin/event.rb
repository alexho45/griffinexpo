ActiveAdmin.register Event do
  permit_params Event.column_names.map(&:to_sym)

  filter :title
  filter :from
  filter :to
  filter :location
end
