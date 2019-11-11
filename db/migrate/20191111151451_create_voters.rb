class CreateVoters < ActiveRecord::Migration[6.0]
  def change
    create_table :voters do |t|
      t.string :name
      t.string :last_name
      t.string :cc
      t.string :city
      t.string :department
      t.references :voting_point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
