# ONGR demo presentation docker image.

[![Build Status](http://img.shields.io/travis/ongr-io/ongr-demo-docker-container/master.svg?style=flat-square)](https://travis-ci.org/ongr-io/ongr-demo-docker-container) [![Docker Hub](https://img.shields.io/badge/docker-demo--presentation-blue.svg?style=flat-square)](https://hub.docker.com/r/ongr/demo-presentation/)

## Walkthrough:
1. Pull the image:
   ```bash
   docker pull ongr/demo-presentation
   ```

2. Run the container:
   ```bash
   docker run -d -p 80:80 --name demo -t ongr/demo-presentation
   ```
3. Run `docker logs` to check when all services are booted up and navigate to your docker host IP address in the browser to view the ONGR demo presentation.
