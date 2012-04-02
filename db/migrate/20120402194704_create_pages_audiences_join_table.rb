class CreatePagesAudiencesJoinTable < ActiveRecord::Migration
  def change
    create_table :pages_audiences, id: false do |t|
      t.integer :page_id
      t.integer :audiences_id
    end
  end
end
