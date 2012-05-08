class DropTableGroupsDepartments < ActiveRecord::Migration
  def up
    add_column :groups, :department_id, :integer

#    Group.find_each do |group|
#      group.department_id = group.departments.first.id
#    end

    drop_table :departments_groups
  end

  def down
    create_table :departments_groups, id: false do |t|
      t.integer :department_id
      t.integer :group_id
    end

#    Group.find_each(:all) do |group|
#      execute "insert into departments_groups values(#{group.department_id}, #{group.id})"
#    end

    remove_column :groups, :department_id
  end
end
