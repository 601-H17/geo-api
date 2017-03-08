class Api::V1::TagsController < ApplicationController

  before_action :require_admin
  before_action :get_classroom, only: :get_tags

  def get_tags
    render json: @classroom.tags, status: 200
  end

  def save_for_classroom
    classroom = Classroom.find(params[:id])
    tags = params[:tags]
    puts tags
    tags.each do |i, t|
      puts "index #{i} for tag #{t}"
      # debugger
      tag = nil
      begin
        tag = Tag.find_by_name!(t[:tag])
      rescue ActiveRecord::RecordNotFound
        Tag.create(name: t[:tag])
        tag = Tag.find_by_name!(t[:tag])
      end

      begin
        classroom.tags.find(tag.id)
      rescue ActiveRecord::RecordNotFound
        tag.classrooms << classroom
      end

    end

    render json: { msg: "Success" }, status: 201
  end

  def delete_tag

  end

  private
    def get_classroom
      @classroom = Classroom.find(params[:id])
    end

end