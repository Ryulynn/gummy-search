class CreateGummies < ActiveRecord::Migration[6.1]
  def change
    create_table :gummies do |t|
      t.string :name
      t.string :image
      t.integer :flavor_id_1
      t.integer :flavor_id_2
      t.integer :flavor_id_3
      t.integer :flavor_id_4

      t.timestamps
    end
  end
end
