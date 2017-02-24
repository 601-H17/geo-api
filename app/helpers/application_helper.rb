#YM:applicationHelper.. trop général comme nom... ici dans cette classe il est question d'update et d'insert ??
module ApplicationHelper

  def parse(filepath)
    file = File.read(filepath)
    JSON.parse file
  end

  def feed_db(json)
    features = json['features']
    features.each do |feature|
      geometry = feature['geometry']
      if geometry['type'] == 'Point' && feature['properties']['entrance'] == 'yes'
        update_or_insert(feature['properties']['ref'], geometry['coordinates'][0], geometry['coordinates'][1])
      end
    end
  end

  def update_or_insert(name, lat, lng)
    floor = name[2..-3]
    point = Point.create(lat: lat, lng: lng)

    classroom = Classroom.where(name: name).first
    if classroom.present?
      puts "#{classroom.name} is present. Updated from floor #{classroom.floor} to #{floor} and from point (#{classroom.point.lat}, #{classroom.point.lng}) to (#{point.lat}, #{point.lng})"
      classroom.update(floor: floor.to_i, point: point)
    else
      classroom = Classroom.new(name: name, floor: floor.to_i, point: point)
      if classroom.valid?
        puts "#{name} is not present. floor #{floor} and point (#{point.lat}, #{point.lng})"
        classroom.save
      end
    end
  end

end
