module ImportCompanies

  def self.parse_and_import(file) #, company_type)
    us = Carmen::Country.coded("us")
    xlsx = Roo::Excelx.new(file)
    sheet = xlsx.sheet(0)
    index = 0
    sheet.each(warehouse:       'Whse',
               account_number:  'Cust #',
               name:            'Description',
               address:         'Address One',
               city:            'City',
               us_state:        'State',
               zip_code:        'Zip',
               phone_number:    'Phone',
               email:           'Email Address'
               ) do |hash|
      index += 1
      next if index == 1

      # company = Company.find_or_create_by(name: hash[:name])
      # if !company[:process_step].present?
      #   us_state = us.subregions.coded(hash[:us_state])
      #   company.update_attributes(warehouse:            hash[:warehouse],
      #                             account_number:       hash[:account_number],
      #                             address:              hash[:address],
      #                             city:                 hash[:city],
      #                             us_state:             us_state,
      #                             zip_code:             hash[:zip_code],
      #                             representative_phone: hash[:phone_number],
      #                             representative_email: hash[:email],
      #                             company_type:         company_type,
      #                             imported:             true)
      # end
      company = Company.find_by(name: hash[:name])
      if company.present?
        company.update_attributes(warehouse:      hash[:warehouse],
                                  account_number: hash[:account_number])
      end
    end
  end

end
