class CreateQuestionsEvents < ActiveRecord::Migration
  def change
    create_table :questions_events do |t|
      t.references :question, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
