module CompaniesHelper

  def states_for_select
    Carmen::Country.named('United States').subregions.typed('state').map(&:name)
  end

  def company_answer_radio(company, possible_answer)
    company.companies_answers.select{|ca| ca.answer_id == possible_answer.id }.try(:first)
  end

  def company_answer(company, question)
    company.companies_answers.select{|ca| ca.question_id == question.id }.try(:first)
  end

end
