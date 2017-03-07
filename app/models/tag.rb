class Tag < ActiveRecord::Base

  has_and_belongs_to_many :classrooms

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}

end
