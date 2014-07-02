class FriendController < ApplicationController


  def fetch_friends
    friends = User.where(['id <> ?', current_user.id])

    # Rails.logger.debug '#######################################################################'

    render json: friends
  end

  def fetch_friend_links
    links = Link.select("links_users.link_name, links.id, links.url, links.category_id").joins('JOIN links_users ON links_users.link_id = links.id').where('links_users.user_id' => params[:id]).order(category_id: :asc)

    render json: links
  end

end
