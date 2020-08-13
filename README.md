# FlickrTest

## Note

Please put a valid key in FlickrApp.xcconfig.

I have ignored Flickr's request to annotate the contributions. I hope that's not within the scope of the app.

Strings, and Reuse-Identifiers could be more safely handled using some library like R.Swift

Currently we are not doing any pagination. (only 100 results are fetched related to any search)

## Work Flow

The app architecture is based on MVVM and procotol based programming. Both MVVM and protocol based approach makes it easy to decouple view from core business logic, hence promoting testability. 

App's main view `PhotoGridViewController` shows Photos based on user's geolocation on app launch. It gets data and business logic from its view-model `PhotoGridViewModel`. 

1. Search: Search flow starts when user enters text in searchBar in `PhotoGridViewController`. PhotoGridVC propagates this change in state to its VM, which as a result fires `searchForText`, making the service call to fetch results into `PhotoModels`. 

2. Generating Filters: Populating photoModels entities triggers `generateFilterModels` which goes through the `photoModels`, gets their tags, and generates `filterModels`. 

3. Geneating filtered list of photos: This triggers the call for `filterPhotos`, which filters the `photoModels` and saves them to `filteredPhotoModels`.

4. Updating view based on search and selected filters: This finally calls the `onDataRefreshed` callback.

Filter Selection: filters state is observed and any change starts the process, from pt.3. Filters are applied, and `onDataRefreshed` is called.


## Third Party Library Usage
For disk and memory caching, we are using SDWebImage which takes care of both of these. (I hope that's ok)


## Unit Testing  ~45% Coverage
Unit tests coverage for business logic in `PhotoGridViewModel`, `DetailViewModel`, `FilterCellViewModel`, `FilterViewModel`. 



## Improvements

* Add UI testing
* Add user annotation
* Add a remove all filters button to `filtersViewController`.
