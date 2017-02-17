# Geo-API [![Build Status](https://travis-ci.org/601-H17/geo-api.svg?branch=master)](https://travis-ci.org/601-H17/geo-api)

`ruby version : 2.3.3`

`rails version : 4.2.0`

### Install Ruby on Rails locally (Docker installation below)

Follow this [guide](http://www.installrails.com). 

For macOS user, on the 'Install RVM and Ruby' step when using `rvm use`, write instead `rvm use ruby-2.3.3@rails4.2.0 --install --default`.

For Linux user, when installing `rvm` and `ruby`, write instead `rvm gemset use ruby-2.3.3@rails4.2.0 --install --default`.

1. Next on a terminal, you need to go in the project directory:
```bash
$ cd the_project/
```
njnjihl
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

### Running Rails on a docker container

####Install [Docker](https://www.docker.com/products/docker) (for Linux and macOS) or [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
Docker works also for Windows, but Hyper-V is required and not compatible with Virtual Box.

1. In a terminal (Docker Toolbox terminal for Windows), go in the project folder 

```bash
$ cd the_project
```
######*Note:* Make sure the ending lines sequences of the dockerfiles are in LF.

2. Build the Docker image...

```bash
$ docker build -t rails-node-api -f ./docker/Dockerfile .
```

2. ...and run it.

```bash
$ docker run -it -p 3000:3000 --rm -v $PWD/:/app rails-node-api
```

## View the server in action
    
In a browser window, go to [localhost:3000](http://localhost:3000) for the admin web app or [localhost:3000/api](http://localhost:3000/api) for the API. If your using Docker ToolBox, use the IP address that shows up when you open the toolbox.
You can use [Postman](https://www.getpostman.com) too to call the API.

### Tests

#### **Unit and integration tests for non-docker users**

To run unit tests:
```bash
$ rake test
```
Or to run a specific test unit file:
```bash
$ rake test test/path/to/file.rb
```
To run integration tests:
```bash
$ cucumber
```

#### **Unit and integration tests for docker users**

1. Build the Docker image...
```bash
$ docker build -t rails-node-api-tests -f ./docker/test .
```

2. To run unit and integration tests: 
```bash
$ docker run -it --rm -v $PWD/:/app rails-node-api-tests
```

*Note: You do not need to re-build the docker if no changes to the dockerfile or any gems were updated.*

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
