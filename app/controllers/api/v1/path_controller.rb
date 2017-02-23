require 'httparty'

class Api::V1::PathController < ApplicationController

  include ClassroomsHelper

  before_action :restrict_access

  rescue_from Errno::ECONNREFUSED, :with => :refused

  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  respond_to :json

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
      message = ""
      local_a.errors.full_messages.each {|e| message += "#{e}, " } if local_a.errors.any?
      local_b.errors.full_messages.each {|e| message += "#{e}, " } if local_b.errors.any?
      render json: { error: "Local not valid (#{message})" }, status: 404
    end
  end

end