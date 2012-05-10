class AddDoneToGroupNeedAudience < ActiveRecord::Migration
  def change
    add_column :groups,    :done, :boolean, default: false
    add_column :needs,     :done, :boolean, default: false
    add_column :audiences, :done, :boolean, default: false
  end
end
