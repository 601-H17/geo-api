class MapController < ApplicationController
  before_action :require_admin

  def display
    gon.map_floor_1 = []
    gon.map_floor_2 = []
    m1 = Map.where(floor: 1, currentMap: true)
    m2 = Map.where(floor: 2, currentMap: true)

    if !m1.empty?
      floor_1 = m1.where(floor: 1).first
      gon.map_floor_1 = get_json_features_from_map("public" + floor_1.map.url) + get_json_features_from_map("public" + floor_1.corridor.url)
    end

    if !m2.empty?
      floor_2 = m2.where(floor: 2).first
      gon.map_floor_2 = get_json_features_from_map("public" + floor_2.map.url) + get_json_features_from_map("public" + floor_2.corridor.url)
    end
  end

  private

  def get_json_features_from_map(path_to_file)
    begin
      map_json = parse(path_to_file)
      map_json = map_json['features']
      return map_json
    rescue => ex
      logger.error ex.message
    end
  end

end

