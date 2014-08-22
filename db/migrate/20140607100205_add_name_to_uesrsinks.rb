class AddNameToUesrsinks < ActiveRecord::Migration
  def change
    add_column :links_users, :links_name, :string
  end
end
