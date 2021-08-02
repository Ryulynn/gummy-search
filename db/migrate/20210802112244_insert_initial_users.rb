class InsertInitialUsers < ActiveRecord::Migration[6.1]
  def change
    User.create(name: "guest", email: "guest@example.com", password: "password", password_confirmation: "password",)
  end
end
