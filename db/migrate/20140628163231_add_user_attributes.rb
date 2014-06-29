class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :weight, :float
    add_column :users, :height, :float
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :phone_number, :string
    add_column :users, :jawbone_xid, :string
    add_column :users, :jawbone_access_token, :string
    add_column :users, :jawbone_access_token_expires_at, :datetime
  end
end
