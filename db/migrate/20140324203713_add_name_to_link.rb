class AddNameToLink < ActiveRecord::Migration
  def change
  	add_column :links, :name, :string
  end
end
