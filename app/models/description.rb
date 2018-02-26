class Description < ApplicationRecord
  belongs_to :customer

  def self.table_name_prefix
    'beary-crm_development.'
  end
end
