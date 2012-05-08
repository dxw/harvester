class Need < ActiveRecord::Base
  include TakableMixin

  attr_accessible :name
  has_and_belongs_to_many :pages, join_table: :pages_needs

  validates_presence_of :name
  validates_uniqueness_of :name

  # Override TakableMixin

  def users_who_can_take_me
    pages.map {|p| p.group.department.users }.flatten
  end

  def done?
    pages.all? do |p|
      !p.new_pages.empty?
    end
  end
end
