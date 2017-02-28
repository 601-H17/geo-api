class Api::V1::StairsController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :stairs, 'Stairs'

  def index
    stairs = Stair.all
    render json: stairs.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
  end

  def show_by_name
    name = params[:name]
    begin
      stair = Stair.find_by_name!(name).to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id)
      render json: stair, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Stair #{name} not found"}, status: 404
    end
  end

end
