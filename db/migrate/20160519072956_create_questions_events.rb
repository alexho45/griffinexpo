class CreateQuestionsEvents < ActiveRecord::Migration
  def change
    create_table :questions_events do |t|
      t.references :question, index: true, foreign_key: true
      t.string :event_references

      t.timestamps null: false
    end
  end
end
