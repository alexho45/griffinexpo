ActiveAdmin.register Company do

  permit_params :name, :registrant, :address, :representative_email, :zip_code, :us_state, :city,
                :representative_phone, :company_type, :access_token, :payment_status,
                :payment_type, :confirmation_token, :process_step,
                attendees_attributes: [:id, :first_name, :last_name,
                                       :email, :phone, :company_id, :_destroy]

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    panel "Attendees" do
      table_for company.attendees do
        Attendee.column_names.each do |c|
          column c.to_sym
        end
      end
    end
  end

  form do |f|
    f.inputs "Company" do
      Company.column_names.each do |c|
        f.input c.to_sym
      end
    end

    f.has_many :attendees do |attendee|
      if !attendee.object.nil?
        attendee.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      unused_fields = ["id", "company_id"] 
      (Attendee.column_names - unused_fields).each do |c|
        attendee.input c.to_sym
      end
    end
    actions
  end

end
