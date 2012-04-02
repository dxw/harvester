class CreateUsersDepartmentsJoinTable < ActiveRecord::Migration
  def change
    create_table :users_departments, id: false do |t|
      t.integer :user_id
      t.integer :department_id
    end
  end
end
