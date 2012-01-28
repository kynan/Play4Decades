class CreateTeamRounds < ActiveRecord::Migration
  def self.up
    create_table :team_rounds do |t|
      t.integer :team_id
      t.integer :decade
      t.float :temperature
      t.float :cumulative_global_co2
      t.timestamps
    end
  end

  def self.down
    drop_table :team_rounds
  end
end
