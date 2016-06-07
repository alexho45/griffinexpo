ActiveAdmin.register Question do
  permit_params Question.column_names.map(&:to_sym),
                answers_attributes: [:id, :value, :title, :_destroy]

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    panel "Answers" do
      table_for question.answers do
        Answer.column_names.each do |c|
          column c.to_sym
        end
      end
    end
  end

  form do |f|
    f.inputs "Question" do
      Question.column_names.each do |c|
        f.input c.to_sym
      end
    end


    # Partials?
    f.has_many :answers do |answer|
      if !answer.object.nil?
        answer.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      unused_fields = ["id", "question_id"] 
      (Answer.column_names - unused_fields).each do |c|
        answer.input c.to_sym
      end
    end
    actions
  end
end
