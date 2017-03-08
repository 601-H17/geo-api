class Api::V1::CorridorsController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :corridors, 'Corridors'

  swagger_api :index do
    summary "Fetch the corridors infos"
    param :header, 'Authorization', :string, :required
    response :ok, "Success", :Corridors
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
  end

  def index
    floor_1 = get_json(1)
    hash = parse("public" + floor_1.corridor.url)
    render json: hash, status: 200
  end

  def corridors2
    floor_2 = get_json(2)
    hash = parse("public" + floor_2.corridor.url)
    render json: hash, status: 200
  end

  private
  def get_json(floor)
    m = Map.where(floor: floor, currentMap: true)
    m.where(floor: floor).first
  end

end
