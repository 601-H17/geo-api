class Classroom < ActiveRecord::Base

  REGEX_NAME = /[A-Z]-[0-9]{3}/
  REGEX_WING = /[A-Z]/

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5, maximum: 5}, format: {with: REGEX_NAME}
  validates :description, length: {maximum: 300}
  validates :wing, presence: true, length: {minimum: 1, maximum: 1}, format: {with: REGEX_WING}
  validates :floor, presence: true, numericality: {only_integer: true}
  validates :point, presence: true

  belongs_to :point
  accepts_nested_attributes_for :point, allow_destroy: true

end
