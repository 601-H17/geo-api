class Stair < ActiveRecord::Base

  REGEX_NAME = /[A-Z]E-[0-9]{1,2}/
  REGEX_WING = /[A-Z]/

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 4, maximum: 5}, format: {with: REGEX_NAME}
  validates :wing, presence: true, length: {minimum: 1, maximum: 1}, format: {with: REGEX_WING}
  validates :floor_min, presence: true, numericality: {only_integer: true}
  validates :floor_max, presence: true, numericality: {only_integer: true}
  validates :point, presence: true

  belongs_to :point

end
