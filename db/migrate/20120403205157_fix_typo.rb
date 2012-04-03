class FixTypo < ActiveRecord::Migration
  def change
    rename_column :pages_audiences, :audiences_id, :audience_id
  end
end
