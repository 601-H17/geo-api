class CorridorsHelperTest < ActionView::TestCase

  test 'should feed db with all entries in the json file' do
    file = 'json_files/corridors.json'

    feed_db(file)
  end

end