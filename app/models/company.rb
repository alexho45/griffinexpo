class Company < ActiveRecord::Base

  has_many :attendees, :through => :companies_attendee
  has_many :companies_attendee, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  has_one :event, :through => :companies_event
  has_one :companies_event, dependent: :destroy

  has_many :packages, :through => :packages_events
  has_many :packages_events, dependent: :destroy

  has_many :hotels, :through => :hotels_events
  has_many :hotels_events, dependent: :destroy

  has_many :answers, :through => :companies_answers
  has_many :companies_answers, dependent: :destroy

  validates_presence_of :company_type
  validates_presence_of :process_step

  POSSIBLE_STEPS = [:select_event, :company_info,
                    :select_packages, :packages_order_verification, :select_payment_type, 
                    :questions, :select_buses,
                    :select_accommodations, :verification, :confirmation]
  VENDOR_STEPS = [:select_event, :company_info, :select_packages,
                  :packages_order_verification, :select_payment_type,
                  :select_accommodations, :verification, :confirmation]
  CUSTOMER_STEPS = [:select_event, :company_info, :questions, :select_buses,
                    :select_accommodations, :verification, :confirmation]
  COMPANY_TYPES = [[:vendor, 'Vendor/Exhibitor'], [:customer, 'Customer/Attendee']]

  enum company_type: [:vendor, :customer]
  enum process_step: POSSIBLE_STEPS
  enum payment_status: [:pending, :accepted, :rejected]
  enum payment_type: [:credit_card, :check, :debit_memo, :other]

  after_create :generate_access_token


  def current_steps
    self.vendor? ? VENDOR_STEPS : CUSTOMER_STEPS
  end

  def next_step
    step = current_steps[current_steps.index(self.process_step.to_sym) + 1]
    set_step(step)
  end

  def previous_step
    step = current_steps[current_steps.index(self.process_step.to_sym) - 1]
    set_step(step)
  end

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

  def apply_payment(type)
    self.update_attribute(:payment_type, type.to_sym)
    self.update_attribute(:payment_status, :pending)
  end

  def complete_registration
    self.set_step(:confirmation)
    self.update_attribute(:confirmation_token, rand(36**8).to_s(36))
  end

private

  def generate_access_token
    self.update_attribute(:access_token, SecureRandom.hex)
  end

end
