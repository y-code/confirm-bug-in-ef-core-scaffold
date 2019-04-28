#!/bin/bash

SD="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
PATH_TO_PROJECT_DIR=$SD/ProjectWithLibReleased
DOCKER_NAME=pg-docker-0
DB_PORT=2345

$SD/run_test.sh $PATH_TO_PROJECT_DIR $DOCKER_NAME $DB_PORT

