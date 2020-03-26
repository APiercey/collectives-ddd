# Lib
This folder contains all application, business, and infrastructure code.

## Overview
* Application contains all Application Services for the domain.
* Domain is the core domain objects and domain services. It attempts to create a single area that expresses OpenCollective.
* Web contains all the necessary code for interaction with the API and querying for domain data.
* Infrastructure classes seperate the responsability of communication. It provides a Repository for Collectives as well as a client for communicating with the OpenCollective API. And lastly, provides helper classes for transforming data between layers of communcation, such as using [ Data Transfer Objects ](https://stackoverflow.com/questions/1051182/what-is-data-transfer-object).

