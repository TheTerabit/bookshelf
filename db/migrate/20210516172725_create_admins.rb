class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :login
      t.string :crypted_password, null: false
      t.string :password_salt, null: false
      t.string :persistence_token, null: false
      t.timestamps
    end
  end
end