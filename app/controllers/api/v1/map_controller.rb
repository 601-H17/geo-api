class Api::V1::MapController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :map, 'Map'

  swagger_api :index do
    summary "Fetch the map infos"
    response :ok, "Success", :Map
    response :unauthorized
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
