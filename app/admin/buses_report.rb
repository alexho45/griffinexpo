ActiveAdmin.register_page "BusesReport" do

  menu label: 'Bus Manifest'

  content do
    render :partial => 'admin/buses_report'
  end

end
