class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
    end

    add_reference :links, :category, index: true
  end
end
