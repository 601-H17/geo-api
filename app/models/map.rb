class Map < ActiveRecord::Base

  mount_uploader :map, MapUploader

  mount_uploader :corridor, MapUploader

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 15}

  validates :floor, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 4}

end
