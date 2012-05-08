class Department < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users, join_table: :users_departments
  has_many :groups
end
