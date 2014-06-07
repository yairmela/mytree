class Link < ActiveRecord::Base
	has_many :users
  belongs_to :category

  def self.fetch_link(url, category_id)
    if !is_exists(url, category_id)
      Link.create(:url => url, :category_id => category_id);
    end
    Link.find_by(:url => url, :category_id => category_id);
  end

  def self.is_exists(url, category_id)
    !Link.where(:url => url, :category_id => category_id).empty?
  end
end
