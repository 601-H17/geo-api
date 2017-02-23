require 'httparty'

class Api::V1::PathController < ApplicationController

  include ClassroomsHelper

  before_action :restrict_access

  # rescue_from Errno::ECONNREFUSED, :with => :refused

  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  respond_to :json

  def find
    local_a = params[:localA]
    local_b = params[:localB]

=begin
    msg = ""

    if validate local_a
      msg += "#{local_a} is ok -- "
    else
      msg += "#{local_a} is not ok\n"
    end

    if validate local_b
      msg += "#{local_b} is ok"
    else
      msg += "#{local_b} is not ok\n"
    end

    render json: { msg: msg }, status: 200
=end

    if validate(local_a) && validate(local_b)

      begin
        response = HTTParty.get("#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}")
        render json: response, status: 200
      rescue Errno::ECONNREFUSED
        render json: { error: "Server could not fulfilled the request, path finding is unavailable. Try it later." }, status: 503
      end

    else
      render json: { error: "Local not valid, it should begin with a capital letter followed by a '-' followed by 3 numbers (e.g. G-164)" }, status: 404
    end
  end

end