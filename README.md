Hello, World Interactive Environment
====================================

"Hello, World" for building IEs

Usage
=====

* Build your own image and run it

 [Docker](https://www.docker.com) is a pre-requirement for this project. You can build the container with:
 ```bash
 $ docker build -t hello-ie .
 ```
 The build process can take some time, but if finished you can run your container with:

 ```bash
 $ docker run -it hello-ie
 ```
* Next, follow the [directions](galaxy-conf/README.md) in the `./galaxy-conf/`
  folder to get the HelloWorld IE installed
* Ensure that the dynamic proxy is available:

  ```bash
  $ cd $GALAXY_ROOT/lib/galaxy/web/proxy/js
  $ npm install .
  ```
* Set the following configuration options in your `$GALAXY_ROOT/config/galaxy.ini` folder:

  ```ini
  dynamic_proxy_manage=True
  dynamic_proxy_session_map=database/session_map.sqlite
  # Pick a free port here
  dynamic_proxy_bind_port=8800
  dynamic_proxy_bind_ip=0.0.0.0
  # Enable verbose debugging of Galaxy-managed dynamic proxy.
  dynamic_proxy_debug=True
  ```
* At this point you should be able to launch Galaxy, upload a text dataset,
  and click "Visualize" and "HelloWorld"
* Galaxy will launch the Interactive Environment in the background:
  ```log
  galaxy.web.base.interactive_environments INFO 2015-07-10 14:19:12,988 Starting docker container for IE helloworld with command [docker run -e "GALAXY_URL=" -e "CORS_ORIGIN=http://localhost:8080" -e "HISTORY_ID=1cd8e2f6b131e891" -e "DOCKER_PORT=32849" -e "PUB_HTTP_PORT=32849" -e "PUB_HOSTNAME=" -e "API_KEY=..." -e "REMOTE_HOST=127.0.0.1" -d --sig-proxy=true -e DEBUG=false -p 32849:80 -v "/home/hxr/work/galaxy/database/tmp/tmpXccEtq:/import/" -v "/home/hxr/work/galaxy/database/files/000/dataset_19.dat:/import/file.txt:ro" hello-ie]
  fa587da7f48c03a025cd158a41003086c7b52d12924bc51f98f581211989ccba
  127.0.0.1 - - [10/Jul/2015:14:19:12 -0500] "GET /visualization/show/helloworld?dataset_id=f09437b8822035f7 HTTP/1.1" 200 - "http://localhost:8080/root" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0"
  ```

  as you can see the container was launched with this command built for you:

  ```console
  $ docker run \
        -e "GALAXY_URL=" \
        -e "CORS_ORIGIN=http://localhost:8080" \
        -e "HISTORY_ID=1cd8e2f6b131e891" \
        -e "DOCKER_PORT=32849" \
        -e "PUB_HTTP_PORT=32849" \
        -e "PUB_HOSTNAME=" \
        -e "API_KEY=..." \
        -e "REMOTE_HOST=127.0.0.1" \
        -d \
        --sig-proxy=true \
        -e DEBUG=false \
        -p 32849:80 \
        -v "/home/hxr/work/galaxy/database/tmp/tmpXccEtq:/import/" \
        -v "/home/hxr/work/galaxy/database/files/000/dataset_19.dat:/import/file.txt:ro" 
        hello-ie
  ```
* In the UI the container should load (with a nice spinner) and then you should see this image:
  ![](./hello-world.png)

Environment Variables
=====================

Several environment variables are available by default, per IE rough standards

Variable            | Use
------------------- | ---
`GALAXY_WEB_PORT`   | Port on which Galaxy is running, if applicable
`NOTEBOOK_PASSWORD` | Password with which to secure the RStudio login. The default username is `galaxy`
`CORS_ORIGIN`       | If the notebook is proxied, this is the URL the end-user will see when trying to access a notebook
`DOCKER_PORT`       | Used in Galaxy Interactive Environments to ensure that proxy routes are unique and accessible
`API_KEY`           | Galaxy API Key with which to interface with Galaxy
`HISTORY_ID`        | ID of current Galaxy History, used in easing the dataset upload/download process
`REMOTE_HOST`       | Unused
`GALAXY_URL`        | URL at which Galaxy is accessible
`DEBUG`             | Enable debugging mode, mostly for developers


Authors
=======

 * Bjoern Gruening
 * Eric Rasche

History
=======

- v0.1: Initial public release

