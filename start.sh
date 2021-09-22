#!/bin/bash

[[ -z "${GH_PAT}" ]] && echo "No gh token!" && exit 1

# clean workdir
rm -rf .git

# git configuration
git config --global credential.helper store
git config --global user.name rzlamrr
git config --global user.email rzlamrr.dvst@protonmail.com

# clone repos
git clone https://rzlamrr:${GH_PAT}@github.com/rzlamrr/usergex
git clone https://github.com/rzlamrr/aria
git clone https://github.com/fakhiralkda/redditGram rgram
git clone https://github.com/fakhiralkda/hyconbot

rm -f ${HOME}/.git-credentials

# run it
screen -dmS A bash -c "cd usergex; bash run"
screen -dmS B bash -c "cd rgram; pip3 install --no-cache-dir -r requirements.txt; bash loop.sh"
screen -dmS C bash -c "cd hyconbot; pip3 install --no-cache-dir -r requirements.txt; python3 -m hycon"
screen -dmS D bash -c "cd aria; bash build.sh"

# keep it alive
while true
do
    echo "####################"
    screen -ls
    sleep 900
done
