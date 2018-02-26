class SnitchRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.table_name_prefix
    db_name = Rails.configuration.database_configuration['snitch_development']['database']
    "#{db_name}."
  end
end

SnitchRecord.establish_connection(Rails.configuration.database_configuration['snitch_development'])
