cd ./app

#Prepare tests db
rake db:test:prepare

#Execute tests
rake test

#Execute integration tests
cucumber