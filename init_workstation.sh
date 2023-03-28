#!/bin/bash

DEFAULT_USER=${DEFAULT_USER:-rstudio}
USER=${USER:=${DEFAULT_USER}}
USERID=${USERID:=1000}
GROUPID=${GROUPID:=1000}

# Create the home directory if not already there
if [ \! -d "/home/${USER}" ]; then
    echo "Creating /home/${USER}"
    mkdir -p "/home/${USER}"
    chmod 0755 "/home"
    chmod 0755 "/home/${USER}"
    chown -R ${USERID}:${GROUPID} "/home/${USER}"
    echo "Done."
else
    echo "Home directory already exists."
fi

echo www-port=80 >> /etc/rstudio/rserver.conf
