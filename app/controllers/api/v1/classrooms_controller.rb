class Api::V1::ClassroomsController < ApplicationController

  before_action :restrict_access

  respond_to :json

  swagger_controller :classrooms, 'Classrooms'

  # GET (all)

  swagger_api :index do
    summary "Fetch the classrooms infos in an array"
    param :header, 'Authorization', :string, :required
    response :ok, "Success", :Map
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
  end

  def index
    classrooms = Classroom.all
    render json: classrooms.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
  end

  # GET (by :id)

  swagger_api :show do
    summary "Fetch the classroom infos from an id"
    param :header, 'Authorization', :string, :required
    param :path, :id, :integer, :required
    response :ok, "Success", :Map
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
    response :not_found
  end

  def show
    id = params[:id]
    begin
      classroom = Classroom.find(id).to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id)
      render json: classroom, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Classroom with id <#{id}> not found" }, status: 404
    end
  end

  # GET (by :name)

  swagger_api :show_by_name do
    summary "Fetch the classroom infos from a name"
    param :header, 'Authorization', :string, :required
    param :path, :name, :string, :required
    response :ok, "Success", :Map
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
    response :not_found
  end

  def show_by_name
    name = params[:name]
    begin
      classroom = Classroom.find_by_name!(params[:name]).to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id)
      render json: classroom, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Classroom #{name} not found"}, status: 404
    end
  end

  # GET (by query, return array of classrooms)

  swagger_api :search_by_name do
    summary "Fetch the classroom infos from a query and return all relevant classrooms"
    param :header, 'Authorization', :string, :required
    param :path, :query, :string, :required
    response :ok, "Success", :Map
    response :unauthorized, '(Unauthorized) Token is not present or token is invalid.'
    response :not_found
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
      render json: classrooms_found.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), status: 200
    else
      render json: { error: "Classroom(s) #{query} not found"}, status: 404
    end

  end

  private
    def classrooms_params
      params.require(:classroom).permit(:name, :description, :floor, :point)
    end

end