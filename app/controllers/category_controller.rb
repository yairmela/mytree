class CategoryController < ApplicationController
  def create
    @category = Category.fetch_category(params[:name] ,params[:parentID])
    # fetch_categories
    render json: @category

  end

  def fetch_categories

    categories = Category.select("categories.id, categories.name, categories.category_id").joins('JOIN links ON links.category_id = categories.id').joins('JOIN links_users ON links.id = links_users.link_id').where('links_users.user_id' => current_user.id).group('categories.id').order(id: :asc)
    Rails.logger.debug("categories:")
    Rails.logger.debug(categories)
    # query = "select from links_users values(#{current_user.id},#{link_id}, '#{link_name}')"
    # ActiveRecord::Base.connection.execute(query)
    # select categories.id, categories.name
    # from users_links, links, categories
    # where users_links.link_id = links.id
    # and links.category_id = categories.id
    # and users_links.user_id = 1

    render json: categories
  end
end
