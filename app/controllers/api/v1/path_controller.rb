require 'httparty'

class Api::V1::PathController < ApplicationController
  include ClassroomsHelper

  rescue_from Errno::ECONNREFUSED, :with => :refused

  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  respond_to :json

  def find
    local_a = params[:localA]
    local_b = params[:localB]
    puts validate(local_a) && validate(local_b)

    puts
    response = HTTParty.get("#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}")
    render json: response, status: 200
  end

  private
    def refused
      render json: { error_message: "Server could not fulfilled the request, path finding is unavailable. Try it later." }, status: 503
    end

end