class Feedback < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  def self.table_name_prefix
    'beary-crm_development.'
  end

end
