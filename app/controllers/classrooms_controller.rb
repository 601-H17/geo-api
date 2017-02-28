class ClassroomsController < ApplicationController

  before_action :require_admin
  before_action :get_classroom, only: [:edit, :update, :destroy]

  # GET /classrooms

  def index
    @classrooms = Classroom.all.order(:name)
  end

  # POST /classrooms

  def create
    @point = Point.new(point_params)
    @classroom = Classroom.new(classroom_params, point: @point)
    if @point.save
      @classroom.point = @point
      if @classroom.save
        debugger
        flash[:success] = "Le local #{@classroom.name} a été créé"
        redirect_to classrooms_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  # GET /classrooms/new

  def new
    @classroom = Classroom.new
    @classroom.point = Point.new
  end

  private
    def classroom_params
      params.require(:classroom).permit(:name, :description, :floor, :wing)
    end

    def point_params
      params.require(:classroom).require(:point_attributes).permit(:lat, :lng)
    end

end
