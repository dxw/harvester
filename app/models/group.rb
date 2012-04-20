class Group < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  has_and_belongs_to_many :departments, join_table: :departments_groups
  has_many :pages

  # Override TakableMixin

  def users_who_can_take_me
    departments.map {|d| d.users }.flatten
  end

  def done?
    pages.all? do |page|
      page.done?
    end
  end
end
