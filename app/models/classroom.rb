class Classroom < ActiveRecord::Base

  REGEX_NAME = /[A-Z]-[0-9]{3}/

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5, maximum: 5}, format: {with: REGEX_NAME}
  validates :description, presence: true, length: {maximum: 300}

  # TODO: ! To test ! #
  validates :floor, presence: true

  belongs_to :point

end
