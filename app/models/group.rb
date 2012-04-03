class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :departments, join_table: :departments_groups
  has_many :pages
end
