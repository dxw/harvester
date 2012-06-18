class Department < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users, join_table: :users_departments
  has_many :groups
  attr_accessible :user_ids

  def next_group(not_id = 0)
    groups.not_done.not_taken.where("id <> ?", not_id).first
  end

  def percentage_groups_done
    done = Group.count(:conditions => "done='t' and department_id = #{self.id}")

    return 0 if done == 0

    ((done.to_f / groups.length) * 100.0).to_i
  end

  # TODO: Could this be done as a proper AR relation?
  def needs(not_id = 0)
    Need.find_by_sql(['select distinct needs.* from needs, pages_needs, pages, groups where needs.id = pages_needs.need_id and pages_needs.page_id = pages.id and pages.group_id = groups.id and groups.department_id = ?', self.id])
  end

  def next_need
    available = needs.select{|r| r.available?}
    available.sample
  end
end
