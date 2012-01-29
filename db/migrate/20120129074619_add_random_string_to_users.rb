class AddRandomStringToUsers < ActiveRecord::Migration
  def change
    add_column :users, :random_string, :string
  end
end
