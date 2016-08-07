Tea and Pronouns
================

## Setup

```sh
make install                # Install dependencies
bundle exec rake db:create  # Create the database
bundle exec rake db:migrate # Migrate the database
```

## Backend dev

```sh
make build          # Compile the front end
bundle exec rails s # Run the backend
# Now go to localhost:3000
```

## Front end dev

```sh
bundle exec rails s # Run the backend
make start          # Run the front end dev server
# Now go to localhost:8080
```

## Testing

```sh
make test         # Run the frontend
bundle exec rake  # Test the backend
bundle exec guard # Run the test watcher
```
