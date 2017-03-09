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
    render json: filter_attr(classrooms), status: 200
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
      classroom = Classroom.find(id)
      render json: filter_attr(classroom), status: 200
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
      classroom = Classroom.find_by_name!(params[:name])
      render json: filter_attr(classroom), status: 200
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
    regexName = name.delete("^a-zA-Z0-9")
    Classroom.all.each do |classname|
      regexClassname = classname.name.delete("^a-zA-Z0-9")
      if regexClassname.downcase.start_with?(regexName)
        classrooms_found.push(classname)
      end
    end

    if classrooms_found.any?
      render json: filter_attr(classrooms_found), status: 200
    else
      render json: { error: "Classroom(s) #{query} not found"}, status: 404
    end

  end

  private
    def classrooms_params
      params.require(:classroom).permit(:name, :description, :floor, :wing, :point)
    end

    def filter_attr(obj)
      obj.to_json(include: { point: {only: [:lat, :lng]}, tags: {only: :name} }, except: [:point_id, :updated_at, :created_at])
    end

end