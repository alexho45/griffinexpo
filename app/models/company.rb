class Company < ActiveRecord::Base

  has_many :attendees
  has_many :events, :through => :companies_event
  has_many :companies_event

  validates_presence_of :company_type
  validates_presence_of :process_step

  STEPS = [:select_event, :company_info, :select_packages, :something_else]
  COMPANY_TYPES = [[:vendor, 'sss'], [:customer, 'sssfff']]

  enum company_type: [:vendor, :customer]
  enum process_step: STEPS
  enum payment_status: [:pending, :accepted, :rejected]
  enum payment_type: []

  after_create :generate_access_token






private

  def generate_access_token
    self.update_attribute(:access_token, SecureRandom.hex)
  end

  def self.get_next_process_step
    if self.company_type.customer? && self.process_step.company_info?
      :company_info
    else
      STEPS[self.process_step + 1]
    end

  end

end
