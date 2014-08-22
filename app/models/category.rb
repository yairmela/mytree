class Category < ActiveRecord::Base
   has_many :links

  def self.fetch_category(name, parent_id)
    if !is_exists(name, parent_id)
      Category.create(:name => name, :category_id => parent_id);
    end
    Category.find_by(:name => name, :category_id => parent_id);
  end

  def self.is_exists(name, parent_id)
    !Category.where(:category_id => parent_id, :name => name).empty?
  end

end
