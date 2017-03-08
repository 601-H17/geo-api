class Api::V1::TagsController < ApplicationController

  before_action :require_admin
  before_action :get_classroom, only: [:get_tags, :delete_tag]

  def get_tags
    render json: @classroom.tags, status: 200
  end

  def save_for_classroom
    classroom = Classroom.find(params[:id])
    tags = params[:tags]
    tags.each do |i, t|
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
    tag_name = params[:tag]
    tag = Tag.find_by_name!(tag_name)
    @classroom.tags.delete(tag)
    render json: { msg: "Success" }, status: 201
  end

  private
    def get_classroom
      @classroom = Classroom.find(params[:id])
    end

end