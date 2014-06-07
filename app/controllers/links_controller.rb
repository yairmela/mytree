class LinksController < ApplicationController

  def create
    link = Link.fetch_link(params[:url], params[:categoryID])
    insert_links_users(link.id, params[:name])
    fetch_links
  end

  def fetch_links
    links = Link.select("links_users.name, links.id, links.url, links.category_id").joins('JOIN links_users ON links_users.link_id = links.id').where('links_users.user_id' => current_user.id).order(category_id: :asc)
    render json: links
  end

  private

  def insert_links_users(link_id, link_name)
    query = "insert into links_users values(#{current_user.id},#{link_id}, '#{link_name}')"
    ActiveRecord::Base.connection.execute(query)
  end

  # def new
  #   @link = Link.new
  #   #ITAY
  # end
  #
  # def show
  #   @link = Link.find(params[:id])
  # end
  #
  # def new_link
  #   a = ['itay' => 'nuss']
  #
  #   render json: a
  # end
  #
  # def show_all
  #   #Rails.logger.debug '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
  #
  #   #@link.testDB
  #   #
  #    @links = Link.all
  #  # @links = Link.where(id: )
  #   #
  #    # @links.each do |link|
  #    #   link.testDB
  #    # end
  #   #
  #   @links = @links.order(category_id: :asc)
  #   render json: @links
  #
  # end
  #
  # def destroy
  #   set_link
  #   @link.destroy!
  #   head :no_content
  # end
  #
  # def create
  #   #Rails.logger.debug '#######################################################################'
  #
  #   @link = Link.new(:parent => params[:parent], :url => params[:value], :name => params[:name], )
  #   if @link.save
  #     render json: @link
  #   else
  #     render json: @link.errors
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_link
  #     @link = Link.find(params[:id])
  #     Rails.logger.debug '----------------------------'
  #     Rails.logger.debug @link
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def getCategoryIDByName(categoryName)
  #     category = Category.where(:name => categoryName)
  #
  #     if ()
  #       Category.new(:name => categoryName)
  #     end
  #
  #   end
end
