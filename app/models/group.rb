class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :departments, join_table: :departments_groups
  has_many :pages

  def taken_by_user
    User.find(self.taken_by)
  end

  def taken?
    !self.taken_by.nil?
  end

  def take! user
    if can_be_taken_by? user
      self.taken_by = user.id
      save!
    else
      raise Exception
    end
  end

  def can_be_taken_by? user
    users_who_can_take_me.include? user
  end

  def users_who_can_take_me
    departments.map {|g| g.users }.flatten
  end

  def taken_by? user
    taken_by == user.id
  end

  def done?
    pages.all? do |page|
      page.done?
    end
  end

  def available?
    !done? && !taken?
  end

  def self.next
    Group.all.select do |g|
      g.available?
    end.first
  end
end
