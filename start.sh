#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

[[ -z "${GH_PAT}" ]] && echo "No gh token!" && exit 1
GIT_CREDS=${HOME}/.git-credentials

# clean workdir
rm -rf .git

# install dependencies
#apt update -qqy
#apt install -qqy apt-utils curl git screen

# git configuration
git config --global credential.helper store
git config --global user.name rzlamrr
git config --global user.email rzlamrr.dvst@protonmail.com

echo "https://rzlamrr:${GH_PAT}@github.com" > ${GIT_CREDS}
chmod 600 ${GIT_CREDS}

# clone repos
git clone https://github.com/rzlamrr/aria -b gh --quiet
git clone https://github.com/fakhiralkda/redditGram --quiet rgram
git clone https://github.com/fakhiralkda/hyconbot --quiet

# run it
screen -dmS A bash -c "cd aria; bash build.sh"
screen -dmS B bash -c "cd rgram; pip3 install -r requirements.txt; bash loop.sh"
screen -dmS C bash -c "cd hyconbot; pip3 install -r requirements.txt; python3 -m hycon"

rm -f ${GIT_CREDS}
