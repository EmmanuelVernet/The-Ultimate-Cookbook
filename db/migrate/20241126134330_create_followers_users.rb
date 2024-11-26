class CreateFollowersUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :followers_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :follower, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
