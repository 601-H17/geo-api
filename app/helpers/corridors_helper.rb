module CorridorsHelper

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
    puts "#{name}, #{lat}, #{lng}"
    floor = name[2..-3]
    point = Point.create(lat: lat, lng: lng)

    classroom = Classroom.where(name: name).first
    if classroom.present?
      Classroom.update(id: classroom.id, {floor: floor, point: point})
    else
      classroom = Classroom.new(name: name, floor: floor.to_i, point: point)
      if classroom.valid?
        classroom.save
      end
    end

    puts Classroom.all
  end

end
