module ClassroomsHelper

  def validate(name)
    Classroom.new(name: name, description: "Random description").valid?
  end

  def update_db

  end

end