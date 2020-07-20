class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    safety_assured do
      execute <<-DDL.squish
        CREATE TYPE users_roles AS ENUM (
          'regular', 'admin'
        );
      DDL
    end

    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.column :role, :users_roles, null: false, default: "regular"
      t.string :reset_password_token, index: true
      t.datetime :reset_password_token_expires_at

      t.timestamps
    end
    add_index :users, "lower(email)", name: "index_users_on_lower_email", unique: true
  end

  def down
    execute <<-DDL.squish
      DROP TYPE users_roles;
    DDL

    drop_table :users
  end
end
