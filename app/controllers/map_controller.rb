class MapController < ApplicationController
  before_action :require_admin

  def display
    map = File.open("json_files/map.json", "rb").read

    map_json = JSON.parse(map)
    map_json = map_json['features']

    gon.map_room = map_json
  end
end
