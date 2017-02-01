class Api::V1::ClassroomsController < ApplicationController

  respond_to :json

  # GET (all)

  def index
    render json: Classroom.all, status: 200
  end

  # GET (by :id)

  # GET (by :wing)

end