class Department < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users, join_table: :users_departments
  has_many :groups

  def next_group
    available = groups.select{|r| r.available?}
    available.sample
  end

  def needs
    Need.find_by_sql(['select distinct needs.* from needs, pages_needs, pages, groups where needs.id = pages_needs.need_id and pages_needs.page_id = pages.id and pages.group_id = groups.id and groups.department_id = ?', self.id])
  end

  def next_need
    available = needs.select{|r| r.available?}
    available.sample
  end
end
