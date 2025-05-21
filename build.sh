#!/bin/bash

podman rmi wavelog
cd container && podman build -t wavelog .
