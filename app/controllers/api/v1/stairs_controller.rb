class Api::V1::StairsController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :stairs, 'Stairs'

  def index
    stairs = Stair.all
    render json: stairs.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
  end



end
