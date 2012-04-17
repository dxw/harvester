class NewPage < ActiveRecord::Base
  belongs_to :page
  attr_accessible :page_id, :uri
end
