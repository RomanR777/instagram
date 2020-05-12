#!/bin/bash
set -e

$APP_HOME/bin/rake db:create
$APP_HOME/bin/rake db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f $APP_HOME/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"