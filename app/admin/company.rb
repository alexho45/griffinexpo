ActiveAdmin.register Company do

  permit_params :name, :registrant, :address, :representative_email, :zip_code, :us_state, :city,
                :representative_phone, :company_type, :access_token, :payment_status, :imported,
                :payment_type, :confirmation_token, :process_step,
                attendees_attributes: [:id, :first_name, :last_name,
                                       :email, :phone, :company_id, :_destroy]

  scope :default, :default => true do |companies|
    companies.where(imported: false)
  end
  scope :imported_vendor do |companies|
    companies.vendor.where(imported: true)
  end
  scope :imported_customer do |companies|
    companies.customer.where(imported: true)
  end

  batch_action :destroy_all_from_this_scope_not_only do |company_ids|
    collection = 
      if params[:scope] == "imported_vendor"
        Company.vendor.where(imported: true)
      elsif params[:scope] == "imported_customer"
        Company.customer.where(imported: true)
      else
        Company.where(imported: false)
      end
    collection.destroy_all
    redirect_to collection_path
  end

  index_unused_fields = ["id", "access_token", "updated_at", "created_at", "imported"]
  index do
    selectable_column
    id_column
    (Company.column_names - index_unused_fields).each do |c|
      column c.to_sym
    end
    actions
  end
  
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
    unused_fields = ["id", "company_id", "updated_at", "created_at"]

    f.inputs "Company" do
      (Company.column_names - unused_fields).each do |c|
        f.input c.to_sym
      end
    end

    f.has_many :attendees do |attendee|
      if !attendee.object.nil?
        attendee.input :_destroy, :as => :boolean, :label => "Destroy?"
      end
      (Attendee.column_names - unused_fields).each do |c|
        attendee.input c.to_sym
      end
    end
    actions
  end

end
