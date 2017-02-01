# Geo API [![Build Status](https://travis-ci.org/601-H17/geo-api.svg?branch=master)](https://travis-ci.org/601-H17/geo-api)

To install Ruby on Rails, follow this [guide](http://www.installrails.com).
 
1. Next on a terminal, you need to go in the project directory:
```bash
$ cd the_project/
```

2. When you're in, restore all the dependencies:
```bash
$ bundle install --without production
```

3. Migrate the db:
```bash
$ rake db:migrate
```

4. (Optional) Seed the db:
```bash
$ rake db:seed
```

5. If everything's good, start the server locally:
```bash
$ rails server
```
Or:
```bash
$ rails s
```
    
Then in a browser window, go to [localhost:3000](http://localhost:3000) for the admin web app or [localhost:3000/api](http://localhost:3000/api) for the API.
You can use [Postman](https://www.getpostman.com) too to call the API.

### Tests

#### Unit tests
To run unit tests:
```bash
$ rake test
```
Or to run a specific test unit file:
```bash
$ rake test test/path/to/file.rb
```

#### Integration tests
To run integration tests:
```bash
$ rake cucumber
```

### Routes

To see all routes, enter:
```bash
$ rake routes
```


### Rails Console

The Rails console is a good way to see everything in the db or create new records:
```bash
$ rails console
```
Or:
```bash
$ rails c
```