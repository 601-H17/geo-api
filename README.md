# Geo API

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

4. If everything's good, start the server locally:
```bash
$ rails server
```
Or:
```bash
$ rails s
```
    
Then in a browser window, go to [localhost:3000](http://localhost:3000) for the admin web app or [localhost:3000/api](http://localhost:3000/api) for the API.
You can use [Postman](https://www.getpostman.com) too to call the API.

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