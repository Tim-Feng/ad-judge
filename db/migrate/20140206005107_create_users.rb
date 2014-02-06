class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password_digest
      t.string :slug
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at
      t.string :email
      t.string :role
      t.timestamps
    end
  end
end
