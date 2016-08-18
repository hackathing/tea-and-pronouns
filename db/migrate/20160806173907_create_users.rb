class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :access_token
      t.string :token
      t.jsonb :preferences, default: {}

      t.index :email, unique: true
      t.index :access_token, unique: true
      t.index :token, unique: true
      t.timestamps
    end
  end
end
