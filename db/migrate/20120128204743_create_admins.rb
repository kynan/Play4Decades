class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :game_id

      t.timestamps
    end
  end
end
