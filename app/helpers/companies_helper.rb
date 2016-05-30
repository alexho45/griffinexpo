module CompaniesHelper

  def states_for_select
    Carmen::Country.named('United States').subregions.typed('state').map(&:name)
  end

end
