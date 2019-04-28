#!/bin/bash

SD="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
PATH_TO_PROJECT_DIR=$SD/ProjectWithLibFixed
DOCKER_NAME=pg-docker-1
DB_PORT=2346

$SD/run_test.sh $PATH_TO_PROJECT_DIR $DOCKER_NAME $DB_PORT

