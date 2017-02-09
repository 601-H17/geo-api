class Api::V1::MapController < ApplicationController
  before_filter :restrict_access
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

  private
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end

end
