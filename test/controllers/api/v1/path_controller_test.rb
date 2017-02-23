require 'test_helper'
require 'webmock/minitest'
require 'httparty'

# TODO: Tests for PathController
class Api::V1::PathControllerTest < ActionController::TestCase

  PATHFINDER_API_URL = ENV['PATHFINDER_URL']

  setup do
    @token = api_keys(:one)
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
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
    local_a, local_b = 'G-165', 'G-160'
    url = "#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}"
    headers = {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'}
    response = { path: [[0, 2], [0, 1], [0, 0]], weight: 0.01}.to_json

    stub_request(:get, url).with(headers: headers)
        .to_return(status: 200, body: response, headers: {"Content-Type" => "application/json"})

    get :find, { localA: local_a, localB: local_b }

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_equal response, @response.body
  end

  test "should not get path with invalid locals" do
    local_a, local_b = 'G-16', 'G-160'

    get :find, { localA: local_a, localB: local_b }

    assert_response :not_found
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Local not valid, it should begin with a capital letter followed by a '-' followed by 3 numbers (e.g. G-164)", @response.body
  end

  test "should not get path with pathfinderAPI response not successful" do
    local_a, local_b = 'G-160', 'G-160'
    url = "#{PATHFINDER_API_URL}?localA=#{local_a}&localB=#{local_b}"

    stub_request(:get, url).to_raise(Errno::ECONNREFUSED)

    get :find, { localA: local_a, localB: local_b }

    assert_response :error
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Server could not fulfilled the request, path finding is unavailable. Try it later.", @response.body
  end

end