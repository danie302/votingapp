class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :voter, null: false, foreign_key: true
      t.references :voting_point, null: false, foreign_key: true
      t.integer :alcaldia
      t.integer :gobernacion

      t.timestamps
    end
  end
end
