# Contact Manager

## Working with the backend

Comments: 
 - Would normally create a spec for the API and would go REST
 - Generally go with RSpec for tests, but just used the generated unit tests
   - Would DRY up the tests and use factories
 - Let most exceptions just bubble through, normally would do better error handling
 - The goal here was to use the generator to do most of the work to save time

Starting up the backend.  Will run on port 3000
```
docker compose up
```

### Adding a contact
```
curl 'http://localhost:3000/add' --data '{ "name": "required name", "email": "required@email.com" }'
```

### Delete a contact
```
curl 'localhost:3000/delete' --data '{ "email": "required@email.com" }'
```

### Search for contact
curl 'localhost:3000/search?name=partial_string'

## Running Tests
Ensure we have the test databases setup
```
docker compose run -e RAILS_ENV=test backend bin/rake db:test:prepare
```

Run the tests
```
docker compose run backend bin/rake test
```

Run the rubocop
```
docker compose run backend bin/rubocop
```



