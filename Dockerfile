FROM ubuntu:22.04

ENV FF_NAME=firefox-latest.tar.bz2 \
    USER_NAME=appuser

RUN apt-get update

RUN useradd --shell /bin/false --create-home ${USER_NAME}

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    xauth \
    apulse \
    unzip \
    bzip2 \
    wget \
    ca-certificates \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    libx11-xcb1 \
    libxtst6 && \
    \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget --progress=dot:mega -O ${FF_NAME} \
         'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' && \
    tar -x -C /usr/local/bin -f ${FF_NAME} && \
    chown -R ${USER_NAME}:${USER_NAME} /usr/local/bin/firefox && \
    rm -f ${FF_NAME}

RUN profile=docker.default && \
    addonsDir=/home/${USER_NAME}/.mozilla/firefox/${profile}/extensions && \
    mkdir -p ${addonsDir} && \
    /bin/echo -e \
      "[General]\n\
       StartWithLastProfile=1\n\
       \n\
       [Profile0]\n\
       Name=default\n\
       IsRelative=1\n\
       Path=${profile}\n\
       Default=1" >> /home/${USER_NAME}/.mozilla/firefox/profiles.ini && \
    chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.mozilla

COPY startup.sh /opt/
RUN chmod +x /opt/startup.sh

COPY bitaddress.org /opt/bitaddress

ENTRYPOINT ["/opt/startup.sh"]
#ENTRYPOINT ["/bin/bash"]

