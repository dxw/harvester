class Audience < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :pages, join_table: :pages_audiences
end
