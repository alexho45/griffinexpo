module ActiveAdmin::ViewsHelper

  def event_attendees_count(event, company_type)
    event_attendees_by_type(event, company_type).count
  end

  def event_hotel_rooms_count(event, company_type)
    HotelsEvent
      .where("company_id in (?)", event.companies.send(company_type).pluck(:id))
      .where(event_id: event.id)
      .sum(:quantity)
  end

  def event_bus_seats_count(event)
    available_seats = event.buses.map(&:available_seats).reduce(0, :+)
    all_seats = event.buses.sum(:seats_limit)
    all_seats - available_seats
  end

  def event_checked_attendees_count(event, company_type)
    (event.checked_attendees & event_attendees_by_type(event, company_type)).count
  end

  def event_attendees_by_type(event, company_type)
    attendees = []
    event.companies.includes(:attendees).send(company_type).each do |company|
      attendees += company.attendees
    end
    attendees
  end

end 
