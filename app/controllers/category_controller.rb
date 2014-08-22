class CategoryController < ApplicationController
  def create
    category = Category.fetch_category(params[:name] ,params[:parentID])

    insert_categories_users(category.id)

    # fetch_categories
    render json: category
  end

  def add_category
    categoryID = params[:id]
    if (!is_user_has_category(categoryID))
      Rails.logger.info "############## [if] add_category id #{categoryID} #########################################################"
      insert_categories_users(categoryID)
    else
      Rails.logger.info "############## [else] add_category id #{categoryID} #########################################################"
    end

    fetch_categories
  end

  def fetch_categories
    categories = Category.select("categories.id, categories.name, categories.category_id").joins('JOIN categories_users ON categories_users.category_id = categories.id').where('categories_users.user_id' => current_user.id).order(id: :asc)

    if (categories.empty?)
      rootCategory = Category.fetch_category('root', 1)
      insert_categories_users(rootCategory.id)
    end

    q = "select DISTINCT id::text, name, category_id::text from fn_get_user_tree(#{current_user.id}) order by id asc, category_id;";
    q2 = "select categories.id, categories.name, categories.category_id from categories join categories_users ON categories_users.category_id = categories.id where categories_users.user_id = #{current_user.id} order by id asc;"

    Rails.logger.info "############## fetch_categories - q = #{q} #########################################################"
    Rails.logger.info "############## fetch_categories - q2 = #{q2} #########################################################"


    r = ActiveRecord::Base.connection.execute(q)

    Rails.logger.info "^^^^^^^^^^^^^^^^^^"
    Rails.logger.info r.to_json
    Rails.logger.info "^^^^^^^^^^^^^^^^^^"
    Rails.logger.info r.as_json
    Rails.logger.info "^^^^^^^^^^^^^^^^^^"
    Rails.logger.info json: r
    Rails.logger.info "^^^^^^^^^^^^^^^^^^"
    Rails.logger.info json: categories
    Rails.logger.info "^^^^^^^^^^^^^^^^^^"

    #render json: categories

    render json: r
  end

  private

  def is_user_has_category(categoryID)
    query = "select category_id from categories_users where user_id = #{current_user.id} and category_id = #{categoryID}"
    # Rails.logger.info "############## is_user_has_category - query = #{query} #########################################################"
    result = ActiveRecord::Base.connection.execute(query)

    !result.num_tuples.zero?
  end

  def insert_categories_users(id)
    query = "insert into categories_users values(#{current_user.id},#{id})"
    ActiveRecord::Base.connection.execute(query)
  end

end
