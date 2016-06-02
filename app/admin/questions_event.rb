ActiveAdmin.register QuestionsEvent do
  permit_params QuestionsEvent.column_names.map(&:to_sym)
end
