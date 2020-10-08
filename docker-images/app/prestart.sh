#! /usr/bin/env sh

echo "Running inside /app/prestart.sh, you could add migrations and wait for db start to this file, e.g.:"

echo "
#! /usr/bin/env bash

# Let the DB start
while ! nc -z $POSTGRES_SERVER 5432; do
  sleep 0.1
done

# Run migrations
#alembic upgrade head

# Create initial data in DB
python /app/app/initial_data.py

"