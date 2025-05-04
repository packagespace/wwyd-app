class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    drop_table :users, if_exists: true do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :remember_token, null: false, limit: 128
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index :email, name: "index_users_on_email"
      t.index :confirmation_token, unique: true, name: "index_users_on_confirmation_token"
      t.index :remember_token, unique: true, name: "index_users_on_remember_token"
    end
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
