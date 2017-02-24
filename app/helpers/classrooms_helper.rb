module ClassroomsHelper

  #YM: c'est pour valider les locaux ? validaterClassRoomName ?
  #YM: il y a des locaux sous la forme C110.01
  #YM: est-ce qu'il a y a des test pour valider ce regex ?
  def validate(name)
    name =~ /[A-Z]-[0-9]{3}/
  end

  def update_db

  end

end