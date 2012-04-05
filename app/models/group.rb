class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :departments, join_table: :departments_groups
  has_many :pages

  def taken_by_user
    User.find(taken_by)
  end

  def taken?
    !taken_by.nil?
  end

  def take! user
    taken_by = user.id
    save!
  end

  def taken_by? user
    taken_by == user.id
  end
end
