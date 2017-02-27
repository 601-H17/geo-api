class ClassroomsController < ApplicationController

  before_action :require_admin
  before_action :get_classroom, only: [:edit, :update, :destroy]

  def index
    @classrooms = Classroom.all.order(:name)
  end

end
