Griffinexpo
===========

Docker workflow
---------------

### Start

Install `docker` once

`eval "$(docker-machine env default)"`

`docker-compose up`

`docker-compose run griffinexpo rake db:seed` once

```open http://`docker-machine ip default````

### Deploy

`docker login` once on server

`cap production deploy`
