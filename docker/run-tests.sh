cd ../app

#Prepare tests db
rake db:test:prepare

#Execute tests
rake test

cd ..

#Execute integration tests
cucumber
