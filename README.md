# Docker for Flarum development

## Instructions

1. Setup Docker, Docker Machine and Docker Compose. [Docker Engine](https://www.docker.com/products/docker-engine) is an easy way to get started if you are new to Docker.

2. Clone this repo:

  ```shell
  $ git clone https://github.com/lucaspiller/docker-flarum-dev.git && cd docker-flarum-dev
  ```

3. Build and start the container (this'll take a few minutes, especially if you
have a slow connection):

  ```shell
  $ docker-compose up
  ```

4. Get the IP:

  ```shell
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

## Tutorial: Creating a Flarum extension

The `flarum` directory is shared with the container as `<flarum root>`, so
anything you put / change there will be available to the container.

These instructions are for Flarum 0.1.0-beta.5, for more details and
support see this forum thread:

https://discuss.flarum.org/d/1608-extension-development-using-composer-repositories-path

1. Create a new directory for the extension:

  ```shell
  $ mkdir -p flarum/workbench/awesome
  ```

2. Create `flarum/workbench/awesome/composer.json`:

   ```json
   {
     "name": "yourname/flarum-awesome",
     "description": "Adds more awesomeness!",
     "type": "flarum-extension",
     "require": {
       "flarum/core": "^0.1.0-beta.5"
     },
     "extra": {
       "flarum-extension": {
         "title": "Awesome"
       }
     }
   }
   ```

3. Create `flarum/workbench/awesome/bootstrap.php`:

  ```php
  <?php

  use Illuminate\Contracts\Events\Dispatcher;
  use Flarum\Event\ConfigureClientView;

  return function (Dispatcher $events) {
  	$events->listen(ConfigureClientView::class, function (ConfigureClientView $event) {
  		if ($event->isForum()) {
  			$event->view->addHeadString("<script>alert('Awesome! It worked!');</script>");
  		}
  	});
  };
  ```

4. Edit `flarum/composer.json`

  Add the repositories section if it doesn't already exist:

  ```json
  "repositories": [
    {
      "type": "path",
      "url": "workbench/*/"
    }
  ]
  ```

  Add your extension to the require section:

  ```json
  "yourname/flarum-awesome": "*@dev"
  ```

5. Update the packages with Composer so it's picked up:

  ```shell
  docker-compose run web php /var/www/composer.phar update -d /var/www/flarum
  ```

5. Enable it at `http://<ip>:5000/admin#/extensions` (you don't need to
   restart the container).

See the Flarum extension guide for more details:

http://flarum.org/docs/extend/start/

## Support

If you have issues related to these Docker scripts, please open an issue here
on GitHub. For any other issues with Flarum and extension development, please
use the support forum:

https://discuss.flarum.org/

## License

Public domain.
