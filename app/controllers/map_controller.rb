class MapController < ApplicationController

  respond_to :json

  def index
    file = File.read('map.json')
    hash = JSON.parse file
    render json: hash, status: 200
  end

end
