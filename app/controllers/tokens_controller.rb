class TokensController < ApplicationController
  before_action :require_admin

  # GET /tokens

  def index
    @tokens = ApiKey.all
  end

end
