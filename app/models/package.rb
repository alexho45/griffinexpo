class Package < ActiveRecord::Base

  def full_name
    "#{name} ($#{price}) <br> (#{description})"
  end
end
