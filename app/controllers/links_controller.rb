class LinksController < ApplicationController

  def new
    @link = Link.new
    #ITAY
  end

  def show
    @link = Link.find(params[:id])
  end

  def new_link
    a = ['itay' => 'nuss']

    render json: a
  end

  def show_all
    #Rails.logger.debug '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'

    #@link.testDB
    #
     @links = Link.all
    #
     # @links.each do |link|
     #   link.testDB
     # end
    #
    @links = @links.order(parent: :asc)
    render json: @links


  end

  def destroy
    set_link
    @link.destroy!
    head :no_content
  end

  def create
    #Rails.logger.debug '#######################################################################'
    @link = Link.new(:parent => params[:parent], :value => params[:value], :name => params[:name])
    if @link.save
      render json: @link
    else
      render json: @link.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
      Rails.logger.debug '----------------------------'
      Rails.logger.debug @link
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    
end
