class Teacher < ActiveRecord::Base

  REGEX_NAME = /(\A[\p{L}\p{M}]{2,})/m

  validates :firstname, presence: true, length: { maximum: 100 }, format: { with: REGEX_NAME }
  validates :lastname, presence: true, length: { maximum: 100 }, format: { with: REGEX_NAME }

end
