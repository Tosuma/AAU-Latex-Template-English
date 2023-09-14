#!/bin/bash

LIST_OF_PACKAGES="build-essential texlive-full python3-pygments python-is-python3 openjdk-11-jdk"
sudo apt update && sudo apt upgrade -y && sudo apt install ${LIST_OF_PACKAGES} -y