class MapController < ApplicationController
  before_action :require_admin

  m1 = Map.where(floor: 1, currentMap: 1)
  PATH_TO_FLOOR_1 = "public" + m1[0].map.url

  m2 = Map.where(floor: 2, currentMap: 1)
  PATH_TO_FLOOR_2 = "public" + m2[0].map.url

  def display
    gon.map_floor_1 = get_json_features_from_map(PATH_TO_FLOOR_1)
    gon.map_floor_2 = get_json_features_from_map(PATH_TO_FLOOR_2)
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

