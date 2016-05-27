class Attendee < ActiveRecord::Base
  has_many :events

  has_one :company, :through => :companies_attendee
  has_one :companies_attendee

  def full_name
    "#{first_name} #{last_name}"
  end
end
