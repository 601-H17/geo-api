class TokensController < ApplicationController
  before_action :require_admin
  before_action :get_admin, only: [:edit, :update]

  # GET /tokens

  def index
    @tokens = ApiKey.all
  end

  # POST /tokens

  def create
    @token = ApiKey.new(token_params)
    if @token.save
      flash[:success] = "Token was successfully generated: #{@token.access_token}"
      redirect_to tokens_path
    else
      render 'new'
    end
  end

  # PUT PATCH /token/:id

  def update
    if @token.update(token_params)
      flash[:success] = "Token was successfully updated"
      redirect_to tokens_path
    else
      render 'edit'
    end
  end

  # GET /tokens/new

  def new
    @token = ApiKey.new
  end

  # GET /token/:id/edit

  def edit

  end

  private
    def token_params
      params.require(:api_key).permit(:name)
    end

    def get_admin
      @token = ApiKey.find(params[:id])
    end

end
