ActiveAdmin.register QuestionsAnswer do
  permit_params QuestionsAnswer.column_names.map(&:to_sym)
end
