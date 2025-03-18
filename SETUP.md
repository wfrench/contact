# Backend Setup

Initial project setup

## Generate rails app
```
docker run -it -v "$PWD":/app -w /app ruby:latest bash
gem install rails && rails new . 
``` 

## Add a docker-compose configuration
docker-compose.yml
```
services:
  backend:
    build: .
    command: bundle exec rails server -b 0.0.0.0 -p 3000
    volumes:
      - .:/rails
    ports:
      - "3000:3000"
```

## Shell into the backend
```
dc run backend bash
```

## Create a contact model
```
bin/rails generate model Contact name:text email:text
```

Then edit the migration file and add the uniq constraint
```
add_index :contact, :email, unique: true
```

## Add a contact controller
```
bin/rails generate controller Contact add delete search
```

## Create our databases
5. create databases
  - bin/rails db:create
  - bin/rails db:migrate
  
