require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

=begin
  test 'should feed db with all entries in the json file' do
    filepath = 'public/uploads/api/map/map.json'
    file = File.read filepath
    json = ActiveSupport::JSON.decode file

    filepath2 = 'public/uploads/api/map/map2.json'
    file2 = File.read filepath2
    json2 = ActiveSupport::JSON.decode file2

    feed_db(json)
    feed_db(json2)
  end
=end

end