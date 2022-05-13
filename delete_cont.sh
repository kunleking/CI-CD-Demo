#!/bin/bash
sudo docker container stop $(docker container ls -aq)
