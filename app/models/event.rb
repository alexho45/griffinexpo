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

  scope :next_events, -> { where(from: (Date.tomorrow..Date.tomorrow+10.years)) }
  scope :past_events, -> { where(to:   (Date.tomorrow-10.years..Date.tomorrow)) }

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

  %w(lunch coctail food_allergies).each do |key_word|
    define_method("#{key_word}_question") do
      questions.find_by(key_word: key_word)
    end
  end
end
