class Api::V1::DocsController < ApplicationController

  respond_to :json

  def index
    path = Rails.public_path + 'api-docs.json'
    hash = parse(path)
    render json: hash, status: 200
  end

end
