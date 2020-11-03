#!/bin/bash
# This is entrypoint for docker image of spree sandbox on docker cloud
echo "xxxxxxxxxxxxxxx This is the store frontend entrypoint"
cd store-frontend
bundle update ddtrace
bundle update msgpack
RAILS_ENV=development bundle exec rails s -p 3000 -b '0.0.0.0'