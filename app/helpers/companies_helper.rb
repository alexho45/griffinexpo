module CompaniesHelper

  def states_for_select
    Carmen::Country.named('United States').subregions.typed('state').map(&:name)
  end

  def company_answer_radio(company, possible_answer, attendee)
    company
      .companies_answers
      .where(answer_id: possible_answer.id, attendee_id: attendee.id)
      .try(:first)
  end

  def company_answer(company, question, attendee)
    company
      .companies_answers
      .where(question_id: question.id, attendee_id: attendee.id)
      .try(:first)
  end

end
