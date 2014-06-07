class AddNameToUesrsinks < ActiveRecord::Migration
  def change
    add_column :links_users, :link_name, :string
  end
end
