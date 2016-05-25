class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.boolean :text_field, default: false

      t.timestamps null: false
    end
  end
end
