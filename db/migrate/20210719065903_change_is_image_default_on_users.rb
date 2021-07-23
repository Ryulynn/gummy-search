class ChangeIsImageDefaultOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :image, from: nil, to: "default_user_icon.jpg"
  end
end
