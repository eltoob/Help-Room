class AddUniToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uni, :string
  end
end
