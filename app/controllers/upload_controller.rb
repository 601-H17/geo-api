class UploadController < ApplicationController



  def show
    # mapUploader.retrieve_from_store!('test.json')
  end

  def upload
    mapUploader = MapUploader.new
    map_file = params[:map]
    mapUploader.store!(map_file)
  end

end