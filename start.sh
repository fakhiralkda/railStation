#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

[[ -z "${GH_PAT}" ]] && echo "No gh token!" && exit 1
GIT_CREDS=${HOME}/.git-credentials

# clean workdir
rm -rf .git

# git configuration
git config --global credential.helper store
git config --global user.name rzlamrr
git config --global user.email rzlamrr.dvst@protonmail.com

# clone repos
git clone https://rzlamrr:${GH_PAT}@github.com/rzlamrr/aria -b gh
git clone https://github.com/fakhiralkda/redditGram rgram
git clone https://github.com/fakhiralkda/hyconbot

rm -f ${GIT_CREDS}

# run it
screen -dmS B bash -c "cd rgram; pip3 install -r requirements.txt; bash loop.sh"
screen -dmS C bash -c "cd hyconbot; pip3 install -r requirements.txt; python3 -m hycon"

cd aria
dockerd
docker build . -t m
docker run -p 80:80 m
