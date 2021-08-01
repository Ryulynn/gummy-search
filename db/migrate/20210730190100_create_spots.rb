class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :address
      t.string :shop
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true
      t.references :gummy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
