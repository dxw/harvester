class Group < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  belongs_to :department
  has_many :pages

  # Override TakableMixin

  def users_who_can_take_me
    department.users
  end

  def done?
    pages.all? do |page|
      page.done?
    end
  end
end
