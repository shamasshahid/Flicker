# FlickrTest

## Note

Please put a valid key in 

## Work Flow

The app uses MVVM to separate the logic from the views.

`PhotoGridViewController` relies on its view-model `PhotoGridViewModel`. 

1. Search flow starts when `PhotoGridViewController` sets `searchString`. This fires `searchForText`, which makes the service call to fetch results into `photoModels`. 
2. This calls `generateFilterModels` which goes through the `photoModels`, gets their tags, puts them in the `filterModels`. 
3. This triggers the call for `filterPhotos`, which filters the `photoModels` and saves them to `filteredPhotoModels`.
4. This finally calls the `onDataRefreshed` callback.

When filters are changed, the callback inside `getFiltersVM`, which takes us to pt.3. Filters are applied, and `onDataRefreshed` is called.


## Unit Testing
Unit tests are in place for `PhotoGridViewModel`, `DetailViewModel`, `FilterCellViewModel`, `FilterViewModel`. Coverage is currently at ~45%.



## Improvements

* Add UI testing?
