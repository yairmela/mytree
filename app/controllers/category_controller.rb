class CategoryController < ApplicationController
  def create
    category = Category.fetch_category(params[:name] ,params[:parentID])

    insert_categories_users(category.id)

    # fetch_categories
    render json: category
  end

  def fetch_categories
    categories = Category.select("categories.id, categories.name, categories.category_id").joins('JOIN categories_users ON categories_users.category_id = categories.id').where('categories_users.user_id' => current_user.id).order(id: :asc)

    if (categories.empty?)
      rootCategory = Category.fetch_category('root', 1)
      insert_categories_users(rootCategory.id)
    end

    render json: categories
  end

  private

  def insert_categories_users(id)
    query = "insert into categories_users values(#{current_user.id},#{id})"
    ActiveRecord::Base.connection.execute(query)
  end

end
