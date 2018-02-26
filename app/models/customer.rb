class Customer < ApplicationRecord
  belongs_to :team
  has_many :feedbacks,dependent: :nullify
  has_and_belongs_to_many :users
  has_one :description

  def self.table_name_prefix
    'beary-crm_development.'
  end

  before_save :default_values
   def default_values
    self.alloted ||= false
     self.potential_level ||= 1
   end
end
