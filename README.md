Tea and Pronouns
================

[![Build Status](https://travis-ci.org/hackathing/tea-and-pronouns.svg?branch=master)](https://travis-ci.org/hackathing/tea-and-pronouns)


## Technical overview

The backend is a Ruby on Rails JSON API. It is backed by a Postgresql
database.

The frontend is a React app. It uses Redux for state management, Redux Loop
for effects management, and CSS Next for styling.


## Setup

Ensure you have NodeJS v4 or higher and Ruby v2.2 installed on your computer.

You will also need the postgresql database installed and running.

```sh
make install                # Install dependencies
bundle exec rake db:create  # Create the database
bundle exec rake db:migrate # Migrate the database
```


## Frontend dev

```sh
make test           # Test the front end
make test-watch     # Run the test watcher

bundle exec rails s # Run the backend
make dev            # Run the frontend dev server
# Now go to localhost:8080
```


## Backend dev

```sh
bundle exec rake    # Test the backend
bundle exec guard   # Run the test watcher

make build          # Compile the frontend
bundle exec rails s # Run the backend
# Now go to localhost:3000
```
