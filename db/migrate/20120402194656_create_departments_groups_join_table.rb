class CreateDepartmentsGroupsJoinTable < ActiveRecord::Migration
  def change
    create_table :departments_groups, id: false do |t|
      t.integer :department_id
      t.integer :group_id
    end
  end
end
