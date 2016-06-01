class AddSeminarAndKeyWordToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :key_word, :string
    add_column :questions, :seminar, :boolean, default: false

    Question.where("title LIKE ?", "%lunch%").update_all(key_word: :lunch)
    Question.where("title LIKE ?", "%“Cocktail”%").update_all(key_word: :coctail)
    Question.where("title LIKE ?", "%food allergies%").update_all(key_word: :food_allergies)
    Question.where("title LIKE ?", "%planning to attend%").update_all(key_word: :days)
  end
end
