class MapController < ApplicationController
  before_action :require_admin

# if works at first, change the current map value to false, continue to enter the if
  def display
    gon.map_floor_1 = []
    gon.map_floor_2 = []

    m1 = get_current_map_by_floor(1)
    m2 = get_current_map_by_floor(2)

    if !m1.empty?
      floor_1 = m1.where(floor: 1).first
      gon.map_floor_1 = get_json_features_from_map("public" + floor_1.map.url)
    end

    if !m2.empty?
      floor_2 = m2.where(floor: 2).first
      gon.map_floor_2 = get_json_features_from_map("public" + floor_2.map.url)

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

  def get_current_map_by_floor(floor)
    Map.where(floor: floor, currentMap: true)
  end

end

