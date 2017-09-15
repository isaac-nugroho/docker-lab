#!/bin/dumb-init /bin/sh
set -e

# Note above that we run dumb-init as PID 1 in order to reap zombie processes
# as well as forward signals to all processes in its session. Normally, sh
# wouldn't do either of these functions so we'd leak zombies as well as do
# unclean termination of all our sub-processes.

# You can set NOMAD_BIND_INTERFACE to the name of the interface you'd like to
# bind to and this will look up the IP and pass the proper -bind= option along
# to Nomad.
# If the data or config dirs are bind mounted then chown them.
# Note: This checks for root ownership as that's the most common case.
if [[ ! -d $NOMAD_DATA_DIR ]]; then
  mkdir -p $NOMAD_DATA_DIR
  chown -R nobody:nobody $NOMAD_DATA_DIR
fi

if [[ ! -d $NOMAD_CONFIG_DIR ]]; then
  mkdir -p $NOMAD_CONFIG_DIR
  chown -R nobody:nobody $NOMAD_CONFIG_DIR
fi

if [ "$(stat -c %u $NOMAD_DATA_DIR)" != "$(id -u nobody)" ]; then
  chown nobody:nobody -R $NOMAD_DATA_DIR
fi
if [ "$(stat -c %u $NOMAD_CONFIG_DIR)" != "$(id -u nobody)" ]; then
  chown nobody:nobody -R $NOMAD_CONFIG_DIR
fi

NOMAD_BIND=
if [ -n "$NOMAD_BIND_INTERFACE" ]; then
  NOMAD_BIND_ADDRESS=$(ip -o -4 addr list $NOMAD_BIND_INTERFACE | head -n1 | awk '{print $4}' | cut -d/ -f1)
  if [ -z "$NOMAD_BIND_ADDRESS" ]; then
    echo "Could not find IP for interface '$NOMAD_BIND_INTERFACE', exiting"
    exit 1
  fi

  NOMAD_BIND="-bind=$NOMAD_BIND_ADDRESS"
  echo "==> Found address '$NOMAD_BIND_ADDRESS' for interface '$NOMAD_BIND_INTERFACE', setting bind option..."
fi

if [ ! -z "$CONSUL_CLIENT_INTERFACE" ]; then
  CONSUL_CLIENT_ADDRESS=$(ip -o -4 addr list $CONSUL_CLIENT_INTERFACE | head -n1 | awk '{print $4}' | cut -d/ -f1)
fi

if [ ! -z "$CONSUL_CLIENT_ADDRESS" -a ! "$CONSUL_CLIENT_ADDRESS" = "0.0.0.0" ]; then
  echo "{ \"consul\": { \"address\": \"$CONSUL_CLIENT_ADDRESS:8500\" }}" > "$NOMAD_CONFIG_DIR/consul.json"
fi
# You can also set the NOMAD_LOCAL_CONFIG environemnt variable to pass some
# Nomad configuration JSON without having to bind any volumes.
if [ -n "$NOMAD_LOCAL_CONFIG" ]; then
	echo "$NOMAD_LOCAL_CONFIG" > "$NOMAD_CONFIG_DIR/local.json"
fi

# If the user is trying to run Nomad directly with some arguments, then
# pass them to Nomad.
if [ "${1:0:1}" = '-' ]; then
  set -- nomad "$@"
fi

# Look for Nomad subcommands.
if [ "$1" = 'agent' ]; then
  shift
  set -- nomad agent \
      -data-dir="$NOMAD_DATA_DIR" \
      -config="$NOMAD_CONFIG_DIR" \
      $NOMAD_BIND \
      "$@"
elif [ "$1" = 'version' ]; then
  # This needs a special case because there's no help output.
  set -- nomad "$@"
elif nomad --help "$1" 2>&1 | grep -q "nomad $1"; then
  # We can't use the return code to check for the existence of a subcommand, so
  # we have to use grep to look for a pattern in the help output.
  set -- nomad "$@"
fi

if [[ ! -d $NOMAD_CONFIG_DIR ]]; then
  mkdir -p $NOMAD_CONFIG_DIR
  chown -R nobody:nobody $NOMAD_CONFIG_DIR
fi

if [[ ! -d $NOMAD_DATA_DIR ]]; then
  mkdir -p $NOMAD_DATA_DIR
  chown -R nobody:nobody $NOMAD_DATA_DIR
fi

exec "$@"
