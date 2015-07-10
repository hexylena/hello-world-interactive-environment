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
* Next, follow the [directions](galaxy-conf/README.md) in the `./galaxy-conf/` folder

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

