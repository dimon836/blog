#!/bin/sh

set -e

echo "Deleting pid file if exists"

if [ -f /blog/tmp/pids/server.pid ]; then
  rm -f /blog/tmp/pids/server.pid
  echo "Deleted"
fi

echo "Run migrations or create dbs"

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup || bundle install

exec "$@"
