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

  def index
    floor_1 = get_current_map_by_floor(1)
    render_map(floor_1)
  end

  def map2
    floor_2 = get_current_map_by_floor(2)
    render_map(floor_2)
  end

  private
  def render_map(floor)
    hash = parse("public" + floor.map.url)
    render json: hash, status: 200
  end

  def get_current_map_by_floor(floor)
    m1 = Map.where(floor: floor, currentMap: true)
    m1.where(floor: floor).first
  end

end
