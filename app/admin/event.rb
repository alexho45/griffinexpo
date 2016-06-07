ActiveAdmin.register Event do
  permit_params Event.column_names.map(&:to_sym),
                buses_attributes: [:id, :title, :seats_limit, :event_id, :_destroy],
                questions_attributes: [:id, :title, :text_field, :key_word,
                                       :seminar, :event_id, :_destroy],
                # hotels_attributes: [:name, :price, :_destroy],
                hotels_events_attributes: [:id, :company_id, :hotel_id, :quantity, :event_id, :_destroy],
                packages_events_attributes: [:id, :company_id, :package_id, :event_id,
                                             :quantity, :electricity, :_destroy]

  filter :title
  filter :from
  filter :to
  filter :location

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

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

    panel "Questions" do
      table_for event.questions do
        Question.column_names.each do |c|
          column c.to_sym
        end

        column "Actions" do |question|
          link_to('Edit', edit_admin_question_path(question))
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

    panel "Hotels Rooms" do
      table_for event.hotels_events do
        HotelsEvent.column_names.each do |c|
          column c.to_sym
        end
      end
    end

    panel "Packages" do
      table_for event.packages_events do
        PackagesEvent.column_names.each do |c|
          column c.to_sym
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

    unused_fields = ["id", "event_id", "company_id", "hotel_id", "package_id"]

    f.has_many :buses do |bus|
      if !bus.object.nil?
        bus.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      (Bus.column_names - unused_fields).each do |c|
        bus.input c.to_sym
      end
    end

    f.has_many :questions do |question|
      if !question.object.nil?
        question.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      (Question.column_names - unused_fields).each do |c|
        question.input c.to_sym
      end
    end

    # f.has_many :hotels do |hotel|
    #   if !hotel.object.nil?
    #     hotel.input :_destroy, :as => :boolean, :label => "Destroy?"
    #   end
    #   (Hotel.column_names - unused_fields).each do |c|
    #     hotel.input c.to_sym
    #   end
    # end

    f.has_many :hotels_events do |hotel_event|
      if !hotel_event.object.nil?
        hotel_event.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      hotel_event.input :company, collection: f.object.companies.confirmation
      hotel_event.input :hotel
      (HotelsEvent.column_names - unused_fields).each do |c|
        hotel_event.input c.to_sym
      end
    end

    f.has_many :packages_events do |package_event|
      if !package_event.object.nil?
        package_event.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      package_event.input :company, collection: f.object.companies.confirmation
      package_event.input :package
      (PackagesEvent.column_names - unused_fields).each do |c|
        package_event.input c.to_sym
      end
    end
    actions
  end
end
