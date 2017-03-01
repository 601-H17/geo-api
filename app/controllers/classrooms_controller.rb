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
        flash[:success] = "Le local #{@classroom.name} a été créé"
        redirect_to classrooms_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  # PUT-PATCH /classrooms/:id

  def update
    if @classroom.point.update(point_params)
      if @classroom.update(classroom_params)
        redirect_to classrooms_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  # GET /classrooms/new

  def new
    @classroom = Classroom.new
    @classroom.point = Point.new
  end

  # GET /classrooms/edit

  def edit

  end

  private
    def classroom_params
      params.require(:classroom).permit(:name, :description, :floor, :wing, :point_attributes)
    end

    def point_params
      params.require(:classroom).require(:point_attributes).permit(:lat, :lng)
    end

    def get_classroom
      @classroom = Classroom.find(params[:id])
    end

end
