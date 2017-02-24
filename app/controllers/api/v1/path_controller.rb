require 'httparty'

class Api::V1::PathController < ApplicationController

  include ClassroomsHelper

  before_action :restrict_access

  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  respond_to :json

  swagger_controller :path, 'Pathfinder'

  swagger_api :find do
    summary "Fetch a path from a local to another"
    param :header, 'Authorization', :string, :required
    param :query, :localA, :string, :required, "Start local"
    param :query, :localB, :string, :required, "End local"
    response :ok, "Success"
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
    response :not_found
  end

  def find
    local_a = params[:localA]
    local_b = params[:localB]

    if validate(local_a) && validate(local_b)

      begin
        response = HTTParty.get("#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}")
        render json: response, status: 200
      rescue Errno::ECONNREFUSED
        render json: { error: "Server could not fulfilled the request, path finding is unavailable. Try it later." }, status: 503
      end

    else
      render json: { error: "Local (#{local_a} or #{local_b}) not valid, it should begin with a capital letter followed by a '-' followed by 3 numbers (e.g. G-164)" }, status: 404
    end
  end

end