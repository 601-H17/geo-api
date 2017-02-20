class UploadController < ApplicationController

  def show
    # mapUploader.retrieve_from_store!('test.json')
  end

  def upload
    if params[:map].present?
      mapUploader = MapUploader.new
      map_file = params[:map]
      mapUploader.store!(map_file)
      flash[:success] = "Successfully upload the file"
    end
  end

end