class AddNameToUesrsinks < ActiveRecord::Migration
  def change
    add_column :links_users, :name, :string
  end
end
