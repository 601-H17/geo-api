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
    #classroom = Classroom.new(name: name, floor: )
    #puts classroom.valid?
    #puts classroom.errors.full_messages
  end

end
