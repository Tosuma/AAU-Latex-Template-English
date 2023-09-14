#!/bin/bash

LIST_OF_PACKAGES="build-essential mactex python3-pygments python-is-python3 openjdk-11-jdk"
brew install --cask update && sudo apt upgrade -y && sudo apt install ${LIST_OF_PACKAGES} -y