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

    create_table :groups do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.index :name, unique: true
      t.index :slug, unique: true
      t.timestamps
    end

    create_table :group_memberships do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :group, index: true, null: false

      t.timestamps
    end
    add_index(:group_memberships, [:user_id, :group_id], unique: true)
    add_foreign_key(:group_memberships, :groups)
    add_foreign_key(:group_memberships, :users)
  end
end
