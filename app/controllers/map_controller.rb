class MapController < ApplicationController

  def display
    # if logged_in?
    #   redirect_to admins_path
    # end
    map = File.open("json_files/map.json", "rb").read

    map_json = JSON.parse(map)
    map_json = map_json['features']

    gon.map_room = map_json
  end
end
