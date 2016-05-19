class CreateQuestionsAnswers < ActiveRecord::Migration
  def change
    create_table :questions_answers do |t|
      t.references :question, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
