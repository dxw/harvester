class Page < ActiveRecord::Base
  attr_accessible :name, :uri
  has_and_belongs_to_many :attributes
  has_and_belongs_to_many :audiences
  has_and_belongs_to_many :needs
end
