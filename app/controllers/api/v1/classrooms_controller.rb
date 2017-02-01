class Api::V1::ClassroomsController < ApplicationController

  respond_to :json

  # GET (all)

  def index
    render json: Classroom.all, status: 200
  end

  # GET (by :id)

  def show
    render json: Classroom.find_by(params[:id])
  end

  # GET (by :wing)


private
  def recipe_params
    params.require(:classroom).permit(:name, :description)
  end

end