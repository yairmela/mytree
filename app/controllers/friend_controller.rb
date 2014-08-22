class FriendController < ApplicationController


  def fetch_friends
    friends = User.where(['id <> ?', current_user.id])

    Rails.logger.info '################################# fetch_friends ######################################'

    render json: friends
  end

  def fetch_friend_tree

    Rails.logger.info '################################# fetch_friend_tree ######################################'

    # links = Link.select("links_users.link_name, links.id, links.url, links.category_id, categories.name as category_name, categories.category_id as category_parent_id")
    #         .joins('JOIN links_users ON links_users.link_id = links.id')
    #         .joins('JOIN categories ON categories.id = links.category_id')
    #         .where('links_users.user_id' => params[:id])
    #         .order(category_id: :asc)
    #
    # render json: links

    userID = params[:id]

    q = "select DISTINCT node_id as id, node_name as name, node_parent_id as category_id, is_link from fn_get_user_full_tree(#{userID}) order by is_link, node_id asc, node_parent_id;";

    r = ActiveRecord::Base.connection.execute(q)

    render json: r

  end

end
