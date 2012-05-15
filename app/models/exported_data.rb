class ExportedData < ActiveRecord::Base
  attr_accessible :department_id, :uri

  def self.export(type)
    exported_data = self.create!
    Resque.enqueue(ExportJob, exported_data.id, type)
    exported_data
  end

  def waiting?
    self.uri.blank?
  end
end
