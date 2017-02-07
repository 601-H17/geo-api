#!/usr/bin/env bash
# Add pathfinder-api

git clone https://github.com/601-H17/pathfinder-api.git
cd pathfinder-api
npm install
node index.js &

cd ../app

# Install dependencies
bundle install --without production

# Reset db
rake db:reset

# Migrate db
rake db:migrate

# Seed db
rake db:seed

# Start server
rails s -b 0.0.0.0