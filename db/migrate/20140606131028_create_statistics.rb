class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :link_id
      t.integer :counter
    end
  end
end
