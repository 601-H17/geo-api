# Geo-API [![Build Status][travis-image-api]][travis-url-api]

`ruby version : 2.3.3`

`rails version : 4.2.0`

### Summary

* [Install Ruby on Rails locally]
* [Running Rails on a docker container]
* [View the server in action]
* [Tests]
* [Routes]
* [Rails Console]
* [Schema of continuous integration of this project]
___

### Install Ruby on Rails locally (Docker installation below)

Follow this [guide] . 

For macOS user, on the 'Install RVM and Ruby' step when using `rvm use`, write instead `rvm use ruby-2.3.3@rails4.2.0 --install --default`.

For Linux user, when installing `rvm` and `ruby`, write instead `rvm gemset use ruby-2.3.3@rails4.2.0 --install --default`.

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

### Running Rails on a docker container

####Install [Docker]  (for Linux and macOS) or [Docker Toolbox]
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
    
In a browser window, go to [localhost:3000] for the admin web app or [localhost:3000/api] for the API. 

If your using **Docker ToolBox** , use the IP address that shows up when you open the toolbox, it should be [192.168.99.100:3000]  (Admin) or [192.168.99.100:3000/api]  (API).

You can use [Postman] too to call the API.

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

> ***Note: You need to clone the project in a directory with no space when you use $PWD.*

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

### Schema of continuous integration of this project
<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/5929986/23719910/0f8047ea-040b-11e7-9aa2-bb299fbef400.png" />
</p>





[travis-image-api]: https://travis-ci.org/601-H17/geo-api.svg?branch=master
[travis-url-api]: https://travis-ci.org/601-H17/geo-api
[Install Ruby on Rails locally]: https://github.com/601-H17/geo-api#install-ruby-on-rails-locally-docker-installation-below
[Running Rails on a docker container]: https://github.com/601-H17/geo-api#running-rails-on-a-docker-container
[View the server in action]: https://github.com/601-H17/geo-api#view-the-server-in-action
[Tests]: https://github.com/601-H17/geo-api#tests
[Routes]: https://github.com/601-H17/geo-api#routes
[Rails Console]: https://github.com/601-H17/geo-api#schema-of-continuous-integration-of-this-project
[Schema of continuous integration of this project]: https://github.com/601-H17/geo-api#schema-of-continuous-integration-of-this-project
[guide]: http://www.installrails.com
[Docker]: https://www.docker.com/products/docker
[Docker Toolbox]: https://www.docker.com/products/docker-toolbox
[localhost:3000]: http://localhost:3000
[localhost:3000/api]: http://localhost:3000/api
[192.168.99.100:3000]: http://192.168.99.100:3000
[192.168.99.100:3000/api]: http://192.168.99.100:3000/api
[Postman]: https://www.getpostman.com