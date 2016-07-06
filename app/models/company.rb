class Company < ActiveRecord::Base
  has_many :attendees, :through => :companies_attendee,
                       after_add: :attendees_changed,
                       after_remove: :attendees_changed
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

  # validates_presence_of :company_type
  # validates_presence_of :process_step

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
  CSV_VENDOR_ATTRIBUTES_LIST = ['Type', 'Name', 'Address', 'Email', 'Phone', 'Represenative',
                                 'Number of Attendees', 'Attendees names', 'Booth packages selected',
                                 'Booth quantity', 'Electricity required', 'Payment method',
                                 'Hotel accomadations required', 'Number of rooms required',
                                 'Number of rooms booked']
  CSV_CUSTOMER_ATTRIBUTES_LIST = ['Type', 'Name', 'Address', 'Email', 'Phone', 'Represenative',
                                 'Number of Attendees', 'Attendees names', 'Transportation Required',
                                 'Attending Cocktail Hour', 'Attending Luncheon Day',
                                 'Specific Food Allergies', 'Hotel accomadations required', 'Number of rooms required',
                                 'Number of rooms booked', 'Seminars']

  enum company_type: [:vendor, :customer]
  enum process_step: POSSIBLE_STEPS
  enum payment_status: [:pending, :accepted, :rejected]
  enum payment_type: [:credit_card, :check, :debit_memo, :other]

  after_create :generate_access_token

  def full_name
    "#{name} (#{representative_email})"
  end

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
    send_confirmation
  end

  def send_confirmation
    ConfirmationMailer.company_confirmation(self).deliver_now if self.representative_email.present?
    # self.attendees.each {|attendee| ConfirmationMailer.attendee_confirmation(attendee).deliver_now }
  end

  %w(days lunch coctail food_allergies).each do |key_word|
    define_method("#{key_word}_answers") do
      companies_answers
        .select{|ca| ca.question_id == event.send("#{key_word}_question").id }
        .group_by(&:answer)
        .map do |answer, array|
          next if !answer.title
          "#{answer.title} (#{array.size})"
        end
        .compact
        .join(', ')
    end
  end

  def seminars_answers
    companies_answers
      .select{|ca| event.seminar_questions.map(&:id).include?(ca.question_id) }
      .group_by(&:question)
      .map do |question, array|
        "#{question.title} (#{array.size})"
      end.join(', ')
  end

  def location
    "#{city} #{us_state}"
  end

  def has_overnight_buses?
    has = false
    self.event.buses.includes(:attendees).where(overnight: true).each do |bus|
      has = true if (bus.attendees & self.attendees).any?
    end
    has
  end

  def has_buses?
    has = false
    self.event.buses.includes(:attendees).each do |bus|
      has = true if (bus.attendees & self.attendees).any?
    end
    has
  end

private

  def attendees_changed(attendee)
    event.update_all_attendees
  end

  def generate_access_token
    self.update_attribute(:access_token, SecureRandom.hex)
  end

end
