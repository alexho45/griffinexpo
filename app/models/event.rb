class Event < ActiveRecord::Base

  has_many :companies, :through => :companies_event
  has_many :companies_event

  has_many :attendees, :through => :attendees_event
  has_many :attendees_event

  has_many :questions, :through => :questions_events
  has_many :questions_events

  def full_name
    "#{title} #{from.strftime("%d %b")} - #{to.strftime("%d %b")} (#{location})"
  end
end
