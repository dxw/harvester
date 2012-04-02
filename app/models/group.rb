class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :departments
  has_many :pages
end
