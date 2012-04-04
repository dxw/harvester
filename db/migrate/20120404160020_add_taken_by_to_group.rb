class AddTakenByToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :taken_by, :integer
  end
end
