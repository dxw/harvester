class Need < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  has_and_belongs_to_many :pages, join_table: :pages_needs

  validates_presence_of :name
  validates_uniqueness_of :name

  before_save do
    self.done = _done?
    true
  end

  # Override TakableMixin

  def users_who_can_take_me
    User.find_by_sql(['select distinct users.* from users, users_departments, groups, pages, pages_needs where users.id = users_departments.user_id and groups.department_id = users_departments.department_id and groups.id = pages.group_id and pages.id = pages_needs.page_id and pages_needs.need_id = ?', self.id])
  end

  def _done?
    pages.all? do |p|
      !p.new_pages.empty?
    end
  end
end
