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

# run it
screen -dmS A bash -c "cd aria; bash build.sh"
screen -dmS B bash -c "cd rgram; pip3 install -r requirements.txt; bash loop.sh"
screen -dmS C bash -c "cd hyconbot; pip3 install -r requirements.txt; python3 -m hycon"

rm -f ${GIT_CREDS}
