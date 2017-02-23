class MapController < ApplicationController
  before_action :require_admin

  def display
    m = Map.where(floor: [1, 2], currentMap: 1)
    floor_1 = m.where(floor: 1).first
    floor_2 = m.where(floor: 2).first
    gon.map_floor_1 = get_json_features_from_map("public" + floor_1.map.url)
    gon.map_floor_2 = get_json_features_from_map("public" + floor_2.map.url)
  end

  private

  def get_json_features_from_map(path_to_file)
    begin
      map = File.open(path_to_file, "rb").read
      map_json = JSON.parse(map)
      map_json = map_json['features']
      return map_json
    rescue => ex
      logger.error ex.message
    end
  end

end

