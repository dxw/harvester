class Group < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  belongs_to :department
  has_many :pages
  belongs_to :user, :foreign_key => 'taken_by'

  before_save do
    self.done = _done?
    true
  end

  # Override TakableMixin

  def users_who_can_take_me
    department.users
  end

  def _done?
    pages.all? do |page|
      page.done?
    end
  end
end
