class AddTaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ta, :boolean
  end
end
