class Need < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  has_and_belongs_to_many :pages, join_table: :pages_needs

  # Override TakableMixin
  def users_who_can_take_me
    pages.map {|p| p.departments.map {|d| d.users }}.flatten
  end
end
