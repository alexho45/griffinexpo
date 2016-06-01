class Event < ActiveRecord::Base

  has_many :companies, :through => :companies_event
  has_many :companies_event, dependent: :destroy

  has_many :attendees, :through => :attendees_event
  has_many :attendees_event, dependent: :destroy

  has_many :questions, :through => :questions_events
  has_many :questions_events, dependent: :destroy

  has_many :buses, :through => :buses_events
  has_many :buses_events

  after_create :init_questions

  def full_name
    "#{title} #{from.strftime("%d %b")} - #{to.strftime("%d %b")} (#{location})"
  end

  def buses_companies
    buses.all.map do |bus|
      bus.attendees_companies
    end.reduce(:+)
  end

  def init_questions
    Question.generate_standard_questions(self)
  end

  # UPDATE THIS LATER with desctiption field

  def lunch_question
    questions.find_by("title LIKE ?", "%lunch%")
  end

  def coctail_question
    questions.find_by("title LIKE ?", "%“Cocktail”%")
  end

  def food_allergies_question
    questions.find_by("title LIKE ?", "%food allergies%")
  end
end
