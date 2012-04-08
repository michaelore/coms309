class ChangeUserPasswordDigest < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :password_digest
    end
    remove_column :users, :hashed_password
  end

  def down
    change_table :users do |t|
      t.string :hashed_password
    end
    remove_column :users, :password_digest
  end
end
