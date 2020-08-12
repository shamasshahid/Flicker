//
//  SearchViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation
import CoreLocation

class PhotoGridViewModel {
    
    private let service: APIService    
    private var locationManager: LocationService
    
    var onDataRefreshed: (() -> Void)?
    
    var locationCoOr: CLLocationCoordinate2D? {
        didSet {
            searchForLocation(locationCoOr: locationCoOr)
        }
    }
    
    public var searchString: String? {
        didSet{
            searchForText(searchString: searchString)
        }
    }
    
    private var photoModels: [PhotoObject] = [] {
        didSet {
            generateFilterModels()
        }
    }
    
    private var filteredPhotoModels: [PhotoObject] = [] {
        didSet {
            onDataRefreshed?()
        }
    }
    
    private var filterModels: [FilterObject] = [] {
        didSet {
            filterPhotos()
        }
    }
    
    var rowCount: Int {
        return filteredPhotoModels.count
    }
    
    init(apiService: APIService, locationManager: LocationService) {
        
        service = apiService
        
        self.locationManager = locationManager
        self.locationManager.locationCallbackListener = self
        
        self.locationManager.requestAccess()
      }
    
    /// Creating Filter objects from all the tags
    private func generateFilterModels() {
        var allTags = Set<String>()
        
        // Getting all the tags, and putting in a Set, to avoid duplicates
        for aPhoto in photoModels {
            allTags = allTags.union(aPhoto.separatedTags)
        }
        // sometimes Flickr's tags are not equi spaced, so removing
        allTags.remove("")
        
        // Sorting them in an array, otherwise they might appear a bit undeterministically
        filterModels = allTags.map({ FilterObject(titleString: $0) }).sorted(by: { (m1, m2) -> Bool in
            return m1.title < m2.title
        })
    }
    
    /// Filtering photos based on the selected filters
    private func filterPhotos() {
        
        let selectedFilters = filterModels.filter({ $0.isSelected })
        
        // return all photos if no selected filters
        if selectedFilters.isEmpty {
            filteredPhotoModels = photoModels
        } else {
            let filterMap = selectedFilters.map({ $0.title })
            
            // going through all the PhotoObjects, and checking if intersection between its tags
            // and selected filterModels, is empty or not. If it's not empty, then it should filter in
            filteredPhotoModels = photoModels.filter({ !(Set($0.separatedTags).intersection(Set(filterMap))).isEmpty })
        }
    }
    
    private func searchForLocation(locationCoOr: CLLocationCoordinate2D?) {
        
        guard let location = locationCoOr else {
            return
        }
        
        service.fetch(urlRequest: SearchRouter.searchWithLocation(latitude: location.latitude, longitude: location.longitude)) {[weak self] result in
            self?.handleFetchedResult(result: result)
        }
    }
    
    private func searchForText(searchString: String?) {
        
        guard let searchText = searchString, !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        service.fetch(urlRequest: SearchRouter.search(searchString: searchText)) { [weak self] (result) in
            self?.handleFetchedResult(result: result)
        }
    }
    
    private  func handleFetchedResult(result: Result<[PhotoObject], NetworkError>) {
        switch result {
        case .success(let fetchedObjects):
            self.photoModels = fetchedObjects
        case .failure(let error):
            print(error)
        }
    }
    
    
    /// Create and return PhotoCellViewModel for the Index to be used for photo Detail View
    /// - Parameter index: Index for the Photo
    /// - Returns: PhotoCellViewModel
    func getModelForCellAt(index: Int) -> PhotoCellViewModel? {
        
        guard let object = getModelForIndex(index: index) else {
            return nil
        }
        
        return PhotoCellViewModel(photoModel: object)
    }
    
    
    private func getModelForIndex(index: Int) -> PhotoObject? {
        
        guard index >= 0 && index < filteredPhotoModels.count else {
            return nil
        }
        return filteredPhotoModels[index]
    }
    
    
    /// Creates and returns FiltersViewModel object
    /// - Returns: FiltersViewModel
    func getFiltersVM() -> FiltersViewModel {
        
        let viewModel = FiltersViewModel(allFilters: filterModels)
        viewModel.onFiltersUpdated = { [weak self] selectedFilters in
            self?.filterModels = selectedFilters
        }
        return viewModel
    }
    
    
    /// Create and returns PhotoDetailViewModel for selected Photo
    /// - Parameter index: Index
    /// - Returns: PhotoDetailViewModel
    func getDetailViewModelForIndex(index: Int) -> PhotoDetailViewModel? {
        guard let model = getModelForIndex(index: index) else {
            return nil
        }
        return PhotoDetailViewModel(model: model)
    }
}

extension PhotoGridViewModel: LocationCallbackListener {
    
    func userLocationObtained(coordinates: CLLocationCoordinate2D) {
        locationCoOr = coordinates
        locationManager.stopUpdatingLocation()
    }
    
    func locationPermissionDenied() {
        print("permission denied")
    }
    
    func locationPermissionGranted(status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
}
