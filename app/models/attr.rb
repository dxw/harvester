class Attr < ActiveRecord::Base
  attr_accessible :name, :description
  has_and_belongs_to_many :pages, join_table: :pages_attributes

  validates_presence_of :name
  validates_uniqueness_of :name
end
