class Api::V1::CorridorsController < ApplicationController

  respond_to :json

  swagger_controller :corridors, 'Corridors'

  swagger_api :index do
    summary "Fetch the corridors infos"
    response :ok, "Success", :Corridors
    response :unauthorized
  end

  def index
    file = File.read('json_files/corridors.json')
    json = JSON.parse file
    status = 200

    render json: json, status: status
  end

  def create
    hash = parse('json_files/corridors.json')
  end

end
