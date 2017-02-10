class TokensController < ApplicationController
  before_action :require_admin

  # GET /tokens

  def index
    @tokens = ApiKey.all
  end

  # POST /tokens

  def create
    @token = ApiKey.new(token_params)
    if @token.save
      flash[:success] = "Token was successfully generated: #{@token.access_token}"
      redirect_to tokens_path(@token)
    else
      render 'new'
    end
  end

  # GET /tokens/new

  def new
    @token = ApiKey.new
  end

  # /tokens/:id

  private
    def token_params
      params.require(:api_key).permit(:name)
    end

end
