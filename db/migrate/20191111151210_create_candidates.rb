class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :last_name
      t.string :cc
      t.text :cv
      t.string :city
      t.string :department
      t.string :postion
      t.references :politic_party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
