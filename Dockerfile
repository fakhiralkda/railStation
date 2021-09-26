FROM rzlamrr/megasdk:focal

EXPOSE 80

ENV DEBIAN_FRONTEND=noninteractive GOOGLE_CHROME_DRIVER=/usr/bin/chromedriver GOOGLE_CHROME_BIN=/usr/bin/google-chrome-stable

RUN apt -qqy update && \
    apt -qqy install --no-install-recommends \
    aria2 curl git gnupg2 unzip wget ffmpeg jq screen libmagic-dev && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i ./google-chrome-stable_current_amd64.deb; apt -fqqy install && \
    rm ./google-chrome-stable_current_amd64.deb && \
    rm -rf /var/lib/apt/lists/* && \
    apt -qqy autoclean

RUN mkdir -p /tmpk/ && \
    cd /tmpk/ && \
    # install chromedriver
    wget -q -O chromedriver.zip http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip  && \
    unzip chromedriver.zip chromedriver -d /usr/bin/ && \
    # install rar
    wget --no-check-certificate -q -O rarlinux.tar.gz http://www.rarlab.com/rar/rarlinux-x64-6.0.0.tar.gz && \
    tar -xzvf rarlinux.tar.gz && \
    cd rar && \
    cp -v rar unrar /usr/bin/ && \
    # clean up
    rm -rf /tmpk

COPY start.sh .

CMD bash start.sh
