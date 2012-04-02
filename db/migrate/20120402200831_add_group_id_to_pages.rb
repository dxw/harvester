class AddGroupIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :group_id, :integer
  end
end
