# Config
The configuration for this application follows a typical Bundler application configuration with the exception of the ProductionApplication class.

# ProductionApplication Class
This class is responsible for _wiring_ up the internals of dependencies and helps making (Depdency Injection)[https://en.wikipedia.org/wiki/Dependency_injection] cleaner while keeping the dependencies explicit.

When running funtional tests, the test suite utilizes a (FuntionalApplication class)[https://github.com/APiercey/collectives-ddd/blob/master/spec/helpers/test_application.rb] to keep test fast.

I felt providing behaviour, unit, or integration tests for these classes was not important to demonstrate DDD or the effectiveness of Integration/Contract testing.
