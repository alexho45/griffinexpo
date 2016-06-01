class Attendee < ActiveRecord::Base
  has_one :event, :through => :attendees_event
  has_one :attendees_event

  has_one :company, :through => :companies_attendee
  has_one :companies_attendee

  def full_name
    "#{first_name} #{last_name}"
  end
end
