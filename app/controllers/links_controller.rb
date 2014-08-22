class LinksController < ApplicationController

  def create
    linkName = params[:name]
    Rails.logger.info "############## create link #{linkName} #########################################################"
    link = Link.fetch_link(params[:url], params[:categoryID])
    insert_links_users(link.id, params[:name])
    fetch_links
  end

  def update
    linkID = params[:id]
    Rails.logger.info "############## update link id #{linkID} #########################################################"

    delete_link(linkID)

    create
  end

  def fetch_links
    links = Link.select("links_users.link_name, links.id, links.url, links.category_id").joins('JOIN links_users ON links_users.link_id = links.id').where('links_users.user_id' => current_user.id).order(category_id: :asc)
    render json: links
  end

  def remove_link
    linkID = params[:id]
    Rails.logger.info "############## remove link id #{linkID} #########################################################"

    delete_link(linkID)

    fetch_links
  end

  private

  def insert_links_users(link_id, link_name)
    query = "insert into links_users values(#{current_user.id},#{link_id}, '#{link_name}')"
    Rails.logger.info("query")
    Rails.logger.info(query)
    ActiveRecord::Base.connection.execute(query)

    update_statistics(link_id)
  end

  def update_statistics(link_id)

    query = "select id, counter from statistics where link_id = #{link_id}"

    results = ActiveRecord::Base.connection.select_rows(query)

    if results.empty?
      query = "insert into statistics (link_id, counter) values (#{link_id}, 1)"
    else
      statistics_id = results[0][0]
      counter = results[0][1].to_i + 1
      query = "update statistics set counter = #{counter} where id = #{statistics_id}"
    end

    ActiveRecord::Base.connection.execute(query)
  end

  def delete_link(link_id)
    query = "delete from links_users where user_id = #{current_user.id} and link_id = #{link_id};"

    ActiveRecord::Base.connection.execute(query)
  end

end
