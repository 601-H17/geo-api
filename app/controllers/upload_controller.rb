class UploadController < ApplicationController
  before_action :require_admin
  before_action :get_map, only: [:edit, :update, :destroy]

  # GET /upload

  def index
    @maps = Map.all
  end

  # POST /upload

  def create
    @map = Map.new(map_params)
    if @map.save
      flash[:success] = "Map was successfully upload"
      redirect_to upload_index_path
    else
      render 'new'
    end
  end

  # PUT PATCH /upload/:id

  def update
    if @map.update(map_params)
      flash[:success] = "Map was successfully updated"
      redirect_to upload_index_path
    else
      render 'edit'
    end
  end

  # DELETE /upload/:id

  def destroy
    key_name = @map.name
    @map.destroy
    flash[:danger] = "#{key_name} was successfully destroyed"
    redirect_to upload_index_path
  end


  # GET /upload/new

  def new
    @map = Map.new
  end

  # GET /upload/:id/edit

  def edit
  end

  private
  def map_params
    params.require(:map).permit(:map, :name, :floor, :currentMap)
  end

  def get_map
    @map = Map.find(params[:id])
  end

end
