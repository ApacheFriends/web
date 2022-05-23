#!/bin/bash
set -e

SSH_KEY=/app/deploy.key

gems_up_to_date() {
  bundle check 1> /dev/null
}

log () {
  echo -e "\033[0;33m$(date "+%H:%M:%S")\033[0;37m ==> $1."
}

## Configure ssh key for deployment
if  [ -f $SSH_KEY ]; then
  mkdir -p /root/.ssh
  cp $SSH_KEY /root/.ssh/id_rsa
  chown root:root /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
fi

if ! gems_up_to_date; then
  log "Installing/Updating Rails dependencies (gems)"
  bundle install
  log "Gems updated"
fi

exec "$@"
