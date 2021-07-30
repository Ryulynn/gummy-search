class AddMakerToGummies < ActiveRecord::Migration[6.1]
  def change
    add_column :gummies, :maker_id, :integer
  end
end
