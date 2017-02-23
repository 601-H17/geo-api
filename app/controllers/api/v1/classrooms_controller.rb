class Api::V1::ClassroomsController < ApplicationController

  before_action :restrict_access

  respond_to :json

  # GET (all)

  def index
    classrooms = Classroom.all
    render json: classrooms.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
  end

  # GET (by :id)

  def show
    render json: Classroom.find_by(params[:id]).to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id)
  end

  # GET (by :name)

  def show_by_name
    name = params[:name]
    begin
      classroom = Classroom.find_by_name!(params[:name]).to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id)
      render json: classroom, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Classroom #{name} not found"}, status: 404
    end
  end

  def search_by_name
    query = params[:query]
    name = params[:query].downcase
    classrooms_found = Array.new

    Classroom.all.each do |classname|
      if classname.name.downcase.start_with?(name)
        classrooms_found.push(classname)
      end
    end

    if classrooms_found.any?
      render json: classrooms_found, status: 200
    else
      render json: { error: "Classroom #{query} not found"}, status: 404
    end

  end

  private
    def classrooms_params
      params.require(:classroom).permit(:name, :description, :floor, :point)
    end

end