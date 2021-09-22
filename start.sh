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
screen -dmS B bash -c "cd rgram; pip3 install -r requirements.txt; bash loop.sh"
screen -dmS C bash -c "cd hyconbot; pip3 install -r requirements.txt; python3 -m hycon"

wget -q -O requirements.txt https://raw.githubusercontent.com/UsergeTeam/Userge/alpha/requirements.txt
pip install -q -r requirements.txt
wget -q -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker-ce.list
apt update -qqy
apt install -qqy docker-ce docker-ce-cli containerd.io

screen -dmS C bash -c "cd aria; docker build . -t chi; docker run -p 80:80 chi"

cd usergex
bash run

# keep it alive
while true
do
    echo "####################"
    screen -ls
    sleep 900
done
