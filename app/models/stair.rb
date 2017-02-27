class Stair < ActiveRecord::Base

  REGEX_NAME = /[A-Z]E-[0-9]{1,2}/

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 4, maximum: 5}, format: {with: REGEX_NAME}
  validates :point, presence: true

  belongs_to :point

end
