class UploadController < ApplicationController
  before_action :require_admin
  before_action :get_map, only: [:edit, :update, :destroy, :make_current_map]

  # GET /upload

  def index
    @maps = Map.all
  end

  # POST /upload

  def create
    @map = Map.new(map_params)
    if @map.save
      flash[:success] = "La carte a été téléversée avec succès."
      redirect_to upload_index_path
    else
      render 'new'
    end
  end

  # PUT PATCH /upload/:id

  def update
    if @map.update(map_params)
      flash[:success] = "La carte a été mise à jour avec succès."
      redirect_to upload_index_path
    else
      render 'edit'
    end
  end

  # DELETE /upload/:id

  def destroy
    key_name = @map.name
    @map.destroy
    flash[:danger] = "#{key_name} a bien été détruite."
    redirect_to upload_index_path
  end


  # GET /upload/new

  def new
    @map = Map.new
  end

  # GET /upload/:id/edit

  def edit
  end

  def make_current_map
    if @map.currentMap
      # map_url = @map.map.url
      # map_json = parse('public' + map_url)
      # feed_db(map_json)
      @map.update({currentMap: false})
      flash[:success] = "La carte #{@map.name} a été désactivé pour l'étage #{@map.floor}."
      redirect_to upload_index_path
    elsif @map.update({currentMap: true})
      flash[:success] = "La carte #{@map.name} a bien été activé pour l'étage #{@map.floor}."
      redirect_to upload_index_path
    end
  end

  private
  def map_params
    params.require(:map).permit(:map, :name, :floor)
  end

  def get_map
    @map = Map.find(params[:id])
  end

end
