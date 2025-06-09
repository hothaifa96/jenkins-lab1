#!/bin/bash

set -e

echo "Creating Docker volume 'jenkins_home'..."
docker volume create jenkins_home

echo "Starting Jenkins container..."
docker run -d \
  --name jenkins \
  -u root \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  -p 8080:8080 \
  -p 50000:50000 \
  jenkins/jenkins:lts

echo "Jenkins is starting..."
echo "Access it at: http://localhost:8080"
echo "Initial admin password (check container logs):"
docker logs -f jenkins 2>&1 | grep -m 1 "Please use the following password"
