require 'test_helper'
require 'webmock/minitest'
require 'httparty'

# TODO: Tests for PathController
class Api::V1::PathControllerTest < ActionController::TestCase

=begin
  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  setup do
    @token = api_keys(:one)
    @request.headers["Authorization"] = @token.access_token
  end

  test "should not get path without token" do
    @request.headers["Authorization"] = nil
    local_a = 'G-165', local_b = 'G-160'

    get :find, { localA: local_a, localB: local_b }

    assert_response :unauthorized
    assert_nil request.headers["Authorization"]
    assert_equal "HTTP Token: Access denied.\n", @response.body
  end

  test "should get path with valid locals and pathfinderAPI response successful" do

    local_a = 'G-165', local_b = 'G-160'

    # stub_request(:get, /api.github.com/).to_return(status: 200, body: "stubbed response")
    # uri = URI('https://api.github.com/repos/thoughtbot/factory_girl/contributors')

    stub_request(:get, /PATHFINDER_API_URLs/)
        .with(headers: { "Authorization" => "Token token=#{@token.access_token}" })
        .to_return(status: 200, body: "stubbed response")

    get :find, { localA: local_a, localB: local_b }

    puts @response.body


    #stub_request(:get, "#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}").to_return(:body => { path: [[0, 2], [0, 1], [0, 0]], weight: 0.01}.to_json, :status => 200)

    #Net::HTTP.stub(:get) { "{ path: [[0, 2], [0, 1], [0, 0]], weight: 0.01}" }

  end
=end

end