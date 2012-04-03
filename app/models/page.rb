class Page < ActiveRecord::Base
  attr_accessible :name, :uri
  has_and_belongs_to_many :attributes, join_table: :pages_attributes
  has_and_belongs_to_many :audiences, join_table: :pages_audiences
  has_and_belongs_to_many :needs, join_table: :pages_needs
end
