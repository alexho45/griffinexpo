class Company < ActiveRecord::Base

  has_many :attendees, :through => :companies_attendee
  has_many :companies_attendee
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  has_one :event, :through => :companies_event
  has_one :companies_event

  has_many :packages, :through => :packages_events
  has_many :packages_events

  validates_presence_of :company_type
  validates_presence_of :process_step

  POSSIBLE_STEPS = [:select_event, :company_info, :select_packages,
                    :questions, :packages_order_verification, :select_payment_system]
  COMPANY_TYPES = [[:vendor, 'Vendor/Exhibitor'], [:customer, 'Customer/Attendee']]

  enum company_type: [:vendor, :customer]
  enum process_step: POSSIBLE_STEPS
  enum payment_status: [:pending, :accepted, :rejected]
  enum payment_type: []

  after_create :generate_access_token



  def set_step(step)
    self.update_attribute(:process_step, step) if step
  end

  def subtotal
    total = 0
    self.packages_events.each do |packages_event|
      total += packages_event.quantity * packages_event.package.price
    end
    total
  end

private

  def generate_access_token
    self.update_attribute(:access_token, SecureRandom.hex)
  end

end
