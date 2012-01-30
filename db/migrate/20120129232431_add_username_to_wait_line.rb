class AddUsernameToWaitLine < ActiveRecord::Migration
  def change
    add_column :wait_lines, :username, :string
  end
end
