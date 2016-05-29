# Docker for Flarum development

## Instructions

1. Setup Docker, Docker Machine and Docker Compose. [Docker Engine](https://www.docker.com/products/docker-engine) is an easy way to get started if you are new to Docker.

2. Clone this repo:

  ```
  $ git clone https://github.com/lucaspiller/docker-flarum-dev.git && cd docker-flarum-dev
  ```

3. Build and start the container (this'll take a few minutes, especially if you
have a slow connection):

  ```
  $ docker-compose up
  ```

4. Get the IP:

  ```
  $ docker-machine ip default
  ```

  (Note that `default` is the default docker-machine machine name - if you used
something else, replace it with that)

5. Go to `http://<ip>:5000/`, use the following database settings:

  * MySQL Host: `db`
  * MySQL Database: `flarum`
  * MySQL Username: `root`
  * MySQL Password: `flarum`
  * Table Prefix: leave blank

6. Start coding!

Once you are done you can press `Ctrl-C` in the docker-compose process to shut
down everything. When you want to to continue, just run `docker-compose up` and
it'll start everything (a lot quicker this time as nothing needs to be build)
so you can continue where you left off (including the database).

## License

Public domain.
