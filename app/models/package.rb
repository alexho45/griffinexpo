class Package < ActiveRecord::Base

  def full_name
    "#{name} ($#{price}) <br> (#{description})"
  end

  def full_name_without_price
    "#{name} <br> (#{description})"
  end
end
