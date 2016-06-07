class Event < ActiveRecord::Base

  has_many :companies, :through => :companies_event
  has_many :companies_event, dependent: :destroy

  has_many :attendees, :through => :attendees_event
  has_many :attendees_event, dependent: :destroy

  has_many :questions, :through => :questions_events
  has_many :questions_events, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  has_many :buses, :through => :buses_events
  has_many :buses_events, dependent: :destroy
  accepts_nested_attributes_for :buses, reject_if: :all_blank, allow_destroy: true

  has_many :hotels, :through => :hotels_events
  has_many :hotels_events, dependent: :destroy
  accepts_nested_attributes_for :hotels, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :hotels_events, reject_if: :all_blank, allow_destroy: true

  has_many :packages, :through => :packages_events
  has_many :packages_events, dependent: :destroy
  accepts_nested_attributes_for :packages_events, reject_if: :all_blank, allow_destroy: true

  has_many :checked_attendees, :through => :check_ins, source: :attendee
  has_many :check_ins

  after_create :init_questions

  scope :future_events, -> { where(from: (Date.tomorrow..Date.tomorrow+10.years)) }
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

  def seminar_questions
    questions.where(seminar: true)
  end

  def update_all_attendees
    self.attendees = companies
                      .includes(:attendees)
                      .map(&:attendees)
                      .reduce(:+)
  end
end
