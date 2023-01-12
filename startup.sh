#!/bin/bash

containerXauthority=/home/${USER_NAME}/.Xauthority
touch ${containerXauthority}
chown ${USER_NAME}:${USER_NAME} ${containerXauthority}

su --shell /bin/sh --command "/usr/local/bin/firefox/firefox --no-remote -P default -new-tab /opt/bitaddress/bitaddress.org.html" ${USER_NAME}

