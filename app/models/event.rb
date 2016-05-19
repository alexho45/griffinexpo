class Event < ActiveRecord::Base

  has_many :companies, :through => :companies_event
  has_many :companies_event

  def full_name
    "#{title} (#{location})"
  end
end
