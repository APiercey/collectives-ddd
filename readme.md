# Collectives Domain Driven Design
This application using Ruby and the [Open Collective](https://opencollective.com/) API to demonstrate how to leverage Domain Driven Design.

The focus was to provide an environment to demonstrate how to implement integration and functional tests - on more important, how to seperate them.

Not all domain logic has been mapped into the Web layer. Some of this in intentional. Some of it is due to lack of spare time. If you would like clarification please just ask :).


## Open Collective
Open Collective allows bodies to transparently recieve money. They provide an open API which we can use to monitor this transprancy. This application has no affiliation with Open collective but only uses the aformentioned API

## Getting Started
```
git@github.com:APiercey/collectives-ddd.git
cd collectives-ddd
make test
# or
make start_server
```

# Table of Contents
- [ Application and Domain logic ]( lib/readme.md )
  - [ Domain indepth ]( lib/domain/readme.md )
- [ Specs ]( spec/readme.md )
- [ Configuration ]( config/readme.md )
- [ Generated Docs ]( docs.txt )

# Points of Interest
The application treats OpenCollective as a blackbox. It attempts to express the domain as domain objects and build features ontop of the API.

- Allows querying of (a limited set of) Collectives with UUIDs instead of slugs.
- A Repository for interacting with the OpenCollective API intransparently.
- Use of specifications for filtering Collectives, expressing the domain, and making concepts explicit.
