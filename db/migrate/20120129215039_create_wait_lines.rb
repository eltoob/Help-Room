class CreateWaitLines < ActiveRecord::Migration
  def change
    create_table :wait_lines do |t|
      t.integer :user_id
      t.string :classroom_id
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
      t.string :username
    end
  end
end
