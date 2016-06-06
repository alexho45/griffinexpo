class Attendee < ActiveRecord::Base
  has_one :event, :through => :attendees_event
  has_one :attendees_event

  has_one :company, :through => :companies_attendee
  has_one :companies_attendee

  has_many :check_ins

  def full_name
    "#{first_name} #{last_name}"
  end

  def checked_seminars
    check_ins.map(&:seminar).compact.join(', ')
  end
end
