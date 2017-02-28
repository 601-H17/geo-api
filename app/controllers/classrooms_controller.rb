class ClassroomsController < ApplicationController

  before_action :require_admin
  before_action :get_classroom, only: [:edit, :update, :destroy]

  # GET /classrooms

  def index
    @classrooms = Classroom.all.order(:name)
  end

  # GET /classrooms/new

  def new
    @classroom = Classroom.new
    @classroom.point = Point.new
  end

end
