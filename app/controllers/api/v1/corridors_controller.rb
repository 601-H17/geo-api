class Api::V1::CorridorsController < ApplicationController

  respond_to :json

  def index
    #file = File.read('corridors.json')
    #hash = JSON.parse file
    #render json: hash, status: 200
    render json: { 'This is' => 'some corridors' }, status: 200
  end

end
