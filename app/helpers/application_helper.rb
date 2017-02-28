module ApplicationHelper

  def parse(filepath)
    file = File.read(filepath)
    JSON.parse file
  end

  def feed_db(json)
    features = json['features']
    features.each do |feature|
      properties = feature['properties']
      geometry = feature['geometry']
      if properties['type'] == 'doors'
        update_or_insert_classroom(feature['properties']['ref'], geometry['coordinates'][0], geometry['coordinates'][1])
      elsif properties['type'] == 'stairs'
        update_or_insert_stair(feature['properties']['ref'], geometry['coordinates'][0], geometry['coordinates'][1])
      end
    end
  end

  def update_or_insert_classroom(name, lat, lng)
    floor = name[2..-3]
    point = Point.create(lat: lat, lng: lng)

    classroom = Classroom.where(name: name).first
    point_lat = point.lat #test
    if classroom.present?

      classroom_lat = classroom.point.lat # test

      puts "#{classroom.name} is present. Updated from floor #{classroom.floor} to #{floor} and from point (#{classroom_lat}, #{classroom.point.lng}) to (#{point_lat}, #{point.lng})"
      classroom.update(floor: floor.to_i, point: point)
    else
      classroom = Classroom.new(name: name, floor: floor.to_i, point: point)
      if classroom.valid?
        puts "#{name} is not present. floor #{floor} and point (#{point_lat}, #{point.lng})"
        classroom.save
      end
    end
  end

  def update_or_insert_stair(name, lat, lng)
    stair_name = "#{name[0..-5]}-#{name[4..-1]}"
    wing = name[0]
    floor = name[3..-3].to_i
    point = Point.create(lat: lat, lng: lng)

    stair = Stair.where(name: stair_name).first
    point_lat = point.lat #test
    if stair.present?
      floor_min = stair.floor_min > floor ? floor : stair.floor_min
      floor_max = stair.floor_max < floor ? floor : stair.floor_max
      puts "Stair #{stair.name} is present. Updated from floor #{stair.floor_min}-#{stair.floor_max} to #{floor_min}-#{floor_max} and from point (#{stair.point.lat}, #{stair.point.lng}) to (#{point_lat}, #{point.lng})"
      stair.update(floor_min: floor_min, floor_max: floor_max, point: point)
      puts "Stair #{stair.name}, floor #{stair.floor_min}-#{stair.floor_max} to #{floor_min}-#{floor_max} and from point (#{stair.point.lat}, #{stair.point.lng}) to (#{point_lat}, #{point.lng})"
    else
      stair = Stair.new(name: stair_name, wing: wing, floor_min: floor.to_i, floor_max: floor.to_i, point: point)
      if stair.valid?
        puts "#{stair_name} is not present. floor #{floor} and point (#{point_lat}, #{point.lng})"
        stair.save
        puts "#{stair.name}, floor #{stair.floor_min}-#{stair.floor_max} and point (#{point_lat}, #{point.lng})"
      else
        puts "Errors: #{stair.errors.full_messages}"
      end
    end
  end

end
