class CreateCompaniesAnswers < ActiveRecord::Migration
  def change
    create_table :companies_answers do |t|
      t.references :company, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
