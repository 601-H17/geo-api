module ClassroomsHelper

  def validate(name)
    name =~ /[A-Z]-[0-9]{3}/
  end

  def update_db

  end

end