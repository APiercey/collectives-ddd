# Specs
Tests are split between two kinds:
- Integration
- Unit

## Unit Tests
These tests exhibit the behavior of the domain and test the business logic it is supposed to convey. They do not query to Open Collective API but rather use a (Fake Repository)[https://8thlight.com/blog/eric-smith/2011/10/27/thats-not-yours.html] for all of it's tests.

## Integration Tests
Integration tests are split into two types:
- "Traditional" integration tests, which test the union between two moving parts.
- ( Contract integration )[https://martinfowler.com/bliki/ContractTest.html] tests, which test the union between this application _and the Open Collective API_.

## Identifying and Running Tests
Individual spec files will utilize tags, such as `:integration` or `:contract`. By running tests with `make test` you will run _all_ tests. If you would like to run a specific set of tests, it is possible using tag filtering:
```
bundle exec rspec --tag integration
```

