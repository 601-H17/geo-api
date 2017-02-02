require 'httparty'

class Api::V1::PathController < ApplicationController
  include ClassroomsHelper

  PATHFINDER_API_URL = 'http://localhost:8080/api/pathfinder?'

  respond_to :json

  def find
    local_a = params[:localA]
    local_b = params[:localB]
    puts validate(local_a) && validate(local_b)
    response = HTTParty.get("#{PATHFINDER_API_URL}localA=#{local_a}&localB=#{local_b}")
    render json: response, status: 200
  end

end