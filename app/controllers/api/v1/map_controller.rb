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
    file = File.read('json_files/map.json')
    hash = JSON.parse file
    render json: hash, status: 200
  end

  def map2
    file = File.read('json_files/map2.json')
    hash = JSON.parse file
    render json: hash, status: 200
  end

end
