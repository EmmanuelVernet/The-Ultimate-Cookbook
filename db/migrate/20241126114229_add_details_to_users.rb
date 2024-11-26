class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_name, :string
    add_column :users, :profile_description, :text
    add_column :users, :allergies, :string, array: true, default: []
    add_column :users, :available_time, :time
    add_column :users, :family_size, :integer
    add_column :users, :budget, :integer
  end
end
