class Question < ActiveRecord::Base

  def self.generate_standard_questions(company)
    if company.customer?
      event_days_total = (event.to - event.from).to_i
      event_days_total.times do |day|
        # Question.create()
      end
    end
  end
end
