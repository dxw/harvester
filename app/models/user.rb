class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_and_belongs_to_many :departments, join_table: :users_departments
  has_many :groups

  #TODO: DRY this

  def groups
    departments.map{|d| d.groups }.flatten.sort.uniq
  end

  def next_group
    available = groups.select{|r| r.available?}

    return nil if available.empty?

    available.sample
  end

  def can_edit_group? resource
    groups.include? resource
  end

  ##

  def needs
    departments.map{|d| d.groups.map {|g| g.pages.map {|p| p.needs } } }.flatten.sort.uniq
  end

  def next_need
    available = needs.select{|r| r.available?}

    return nil if available.empty?

    available.sample
  end

  def can_edit_need? resource
    needs.include? resource
  end
end
