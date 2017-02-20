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
      redirect_to maps_path
    else
      render 'new'
    end
  end

  # PUT PATCH /upload/:id

  def update
    # if @token.update(token_params)
    #   flash[:success] = "Token was successfully updated"
    #   redirect_to tokens_path
    # else
    #   render 'edit'
    # end
  end

  # DELETE /upload/:id

  def destroy
    # key_name = @token.name
    # @token.destroy
    # flash[:danger] = "#{key_name} was successfully revoked"
    # redirect_to tokens_path
  end

  # GET /upload/new

  def new
    # @token = ApiKey.new
  end

  # GET /upload/:id/edit

  def edit

  end

  private
  def map_params
    params.require(:map).permit(:map, :name)
  end

  def get_map
    @map = Map.find(params[:id])
  end

end