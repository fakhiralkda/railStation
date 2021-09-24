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

pip3 install virtualenv

# run it
screen -dmS A bash -c "cd usergex; bash rail.sh"
screen -dmS B bash -c "cd rgram; bash rail.sh"
screen -dmS C bash -c "cd hyconbot; bash rail.sh"
#screen -dmS D bash -c "cd aria; bash build.sh"

cd aria
bash build.sh

# clean apt package
apt autoclean -qqy
apt autoremove -qqy

# keep it alive
while true
do
    echo "####################"
    screen -ls
    sleep 900
done
