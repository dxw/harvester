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

  def groups
    departments.map{|d| d.groups }.flatten
  end

  def next_group
    available_groups = groups.select{|g| g.available?}

    return nil if available_groups.empty?

    available_groups.sample
  end
end
