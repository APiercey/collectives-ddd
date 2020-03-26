# Domain
The Collective domain is a representation of the OpenCollective "blackbox".

## Individual Components
- Collective: The root aggregate for the domain. Provides information about the collective itself and access to any sub-domain objects.
- FinancialReport: A value object provides information about a collectives financials.
- Specifications: The specifications under `lib/domain/` provide an intention revealing separation based upon the property values of the aggregate.
- Shared Folder: Contains shared classes (or even helper classes) that is coupled the domain.
- AssetsService: Provide an intention revealing interface for calculating the summed assets that collectives posses.

