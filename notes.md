T&P

To run server

```sh
rails s
```
To start and run postgres database via docker:

```sh
docker start postgres
```

To drop, create and migrate database

```sh
rake db:drop:all db:create db:migrate
```

Notes on Fetch:
So the problem is that if i do my_hash[:foo] when my_hash has no :foo key it returns nil
And then if I chain on another [:bar] I get an error because nil doesn't implement a [] method
So what if I used a method that returned something that did have that method on it instead, as a default value
The thing I want to index into is a hash, so I could use an empty hash
my_hash.fetch(:foo, {})[:bar] for example
.fetch is like [], but it takes a second arg, which is a default value to use
