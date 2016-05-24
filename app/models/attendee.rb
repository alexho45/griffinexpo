class Attendee < ActiveRecord::Base
  belongs_to :company
  has_many :events

  def full_name
    "#{first_name} #{last_name}"
  end
end
