class Api::V1::ClassroomsController < ApplicationController

  before_filter :restrict_access

  respond_to :json

  # GET (all)

  def index
    classrooms = Classroom.all
    render json: classrooms.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
  end

  # GET (by :id)

  def show
    render json: Classroom.find_by(params[:id])
  end

  # GET (by :wing)

  def show_by_name
    name = params[:name]
    begin
      classroom = Classroom.find_by_name!(params[:name])
      render json: classroom, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Classroom #{name} not found"}, status: 404
    end
  end

  def search_by_name
    name = params[:query].downcase
    ary = Array.new
    begin
      Classroom.all.each do |classname|
        if classname.name.downcase.start_with?(name)
          ary.push(classname)
        end
      end
      render json: ary, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Classroom #{name} not found"}, status: 404
    end
  end

  private
    def recipe_params
      params.require(:classroom).permit(:name, :description, :floor)
    end

end