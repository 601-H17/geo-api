class Map < ActiveRecord::Base

  mount_uploader :map, MapUploader
  #YM: où sont les tests pour vérifier les validations ?
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 15}
end
