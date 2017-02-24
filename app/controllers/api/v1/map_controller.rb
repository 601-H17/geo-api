class Api::V1::MapController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :map, 'Map'

  swagger_api :index do
    summary "Fetch the map infos"
    param :header, 'Authorization', :string, :required
    response :ok, "Success", :Map
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
  end

  #YM: éviter la répétition.. 
  def index
    m1 = Map.where(floor: 1, currentMap: true)
    floor_1 = m1.where(floor: 1).first
    hash = parse("public" + floor_1.map.url)
    render json: hash, status: 200
  end

  def map2
    m2 = Map.where(floor: 2, currentMap: true)
    floor_2 = m2.where(floor: 2).first
    hash = parse("public" + floor_2.map.url)
    render json: hash, status: 200
  end

end
