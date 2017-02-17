class CorridorsHelperTest < ActionView::TestCase

  test 'should feed db with all entries in the json file' do
    filepath = 'json_files/corridors.json'
    file = File.read filepath
    json = ActiveSupport::JSON.decode file

    feed_db(json)
  end

end