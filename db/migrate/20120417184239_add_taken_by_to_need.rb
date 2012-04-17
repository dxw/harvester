class AddTakenByToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :taken_by, :integer
  end
end
