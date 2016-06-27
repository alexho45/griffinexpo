ActiveAdmin.register Event do
  permit_params Event.column_names.map(&:to_sym),
                buses_attributes: [:id, :title, :seats_limit, :event_id, :_destroy],
                questions_attributes: [:id, :title, :text_field, :key_word,
                                       :seminar, :event_id, :_destroy],
                hotels_events_attributes: [:id, :company_id, :hotel_id, :quantity, :event_id, :_destroy],
                packages_events_attributes: [:id, :company_id, :package_id, :event_id,
                                             :quantity, :electricity, :_destroy]

  filter :title
  filter :from
  filter :to
  filter :location

  questions_heading = "You can update question answers in question admin panel after adding/saving question here.
                       For seminar and text_field questions you should not add answers.
                       Can be only seminar or text_field in one time."

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    h2 class: 'accordion accordion-admin-panel-show' do
      para "Buses"
    end
    div class: 'accordion-content' do
      panel "Buses" do
        table_for event.buses do
          Bus.column_names.each do |c|
            column c.to_sym
          end

          column "Actions" do |bus|
            link_to('View', admin_bus_path(bus))
          end
        end
      end
    end

    h2 class: 'accordion accordion-admin-panel-show' do
      para "Questions"
    end
    div class: 'accordion-content' do
      panel "Questions. #{questions_heading}" do
        table_for event.questions do
          Question.column_names.each do |c|
            column c.to_sym
          end

          column "Actions" do |question|
            link_to('Edit', edit_admin_question_path(question))
          end
        end
      end
    end

    # panel "Hotels" do
    #   table_for event.hotels do
    #     Hotel.column_names.each do |c|
    #       column c.to_sym
    #     end
    #   end
    # end

    h2 class: 'accordion accordion-admin-panel-show' do
      para "Hotels Rooms"
    end
    div class: 'accordion-content' do
      panel "Hotels Rooms" do
        table_for event.hotels_events do
          HotelsEvent.column_names.each do |c|
            column c.to_sym
          end
        end
      end
    end

    h2 class: 'accordion accordion-admin-panel-show' do
      para "Packages"
    end
    div class: 'accordion-content' do
      panel "Packages" do
        table_for event.packages_events do
          PackagesEvent.column_names.each do |c|
            column c.to_sym
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Event" do
      Event.column_names.each do |c|
        f.input c.to_sym
      end
    end

    unused_fields = ["id", "event_id", "company_id", "hotel_id", "package_id", "updated_at", "created_at"]

    h2 class: 'accordion accordion-admin-panel' do
      para "Buses"
    end
    div class: 'accordion-content' do
      f.has_many :buses do |bus|
        if !bus.object.nil?
          bus.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        (Bus.column_names - unused_fields).each do |c|
          bus.input c.to_sym
        end
      end
    end

    h2 class: 'accordion accordion-admin-panel' do
      para "Questions"
    end
    div class: 'accordion-content' do
      f.has_many :questions, heading: "Questions. #{questions_heading}" do |question|
        if !question.object.nil?
          question.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        (Question.column_names - unused_fields).each do |c|
          question.input c.to_sym
        end
      end
      para questions_heading
    end

    # f.has_many :hotels do |hotel|
    #   if !hotel.object.nil?
    #     hotel.input :_destroy, :as => :boolean, :label => "Destroy?"
    #   end
    #   (Hotel.column_names - unused_fields).each do |c|
    #     hotel.input c.to_sym
    #   end
    # end

    h2 class: 'accordion accordion-admin-panel' do
      para "Hotel rooms"
    end
    div class: 'accordion-content' do
      f.has_many :hotels_events, heading: 'Hotel rooms' do |hotel_event|
        if !hotel_event.object.nil?
          hotel_event.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        hotel_event.input :company, collection: f.object.companies.confirmation
        hotel_event.input :hotel
        (HotelsEvent.column_names - unused_fields).each do |c|
          hotel_event.input c.to_sym
        end
      end
    end

    h2 class: 'accordion accordion-admin-panel' do
      para "Packages"
    end
    div class: 'accordion-content' do
      f.has_many :packages_events, heading: 'Packages' do |package_event|
        if !package_event.object.nil?
          package_event.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        package_event.input :company, collection: f.object.companies.confirmation
        package_event.input :package
        (PackagesEvent.column_names - unused_fields).each do |c|
          package_event.input c.to_sym
        end
      end
    end
    actions
  end
end
