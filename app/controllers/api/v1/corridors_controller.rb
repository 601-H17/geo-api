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
    hash = JSON.parse file
    render json: hash, status: 200
  end

  def create

  end

end
