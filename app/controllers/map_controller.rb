class MapController < ApplicationController
  before_action :require_admin

  def display

    map1 = File.open("json_files/map.json", "rb").read
    map_json1 = JSON.parse(map1)
    map_json1 = map_json1['features']
    gon.map_floor_1 = map_json1

    map2 = File.open("json_files/map2.json", "rb").read
    map_json2 = JSON.parse(map2)
    map_json2 = map_json2['features']
    gon.map_floor_2 = map_json2

  end
end

