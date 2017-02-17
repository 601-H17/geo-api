module ApplicationHelper

  def parse(filepath)
    file = File.read(filepath)
    JSON.parse file
  end

end
