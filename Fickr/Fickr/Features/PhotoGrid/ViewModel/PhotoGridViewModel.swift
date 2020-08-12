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
    private let locationManager: LocationManager
    
    var onDataRefreshed: (() -> Void)?
    
    var locationCoOr: CLLocationCoordinate2D? {
        didSet {
            makeLocationBasedCall(locationCoOr: locationCoOr)
        }
    }
    
    public var searchString: String? {
        didSet{
            makeSearchCall(searchString: searchString ?? "")
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
            filterCurrentResults()
        }
    }
    
    var rowCount: Int {
        return filteredPhotoModels.count
    }
    
    init(apiService: APIService, cLocationManager: LocationManager) {
          service = apiService
          locationManager = cLocationManager
        locationManager.locationCallbackListener = self
        locationManager.requestAccess()
      }
    
    //TODO: add comments to explain this method
    private func generateFilterModels() {
        var allTags = Set<String>()
        
        for aPhoto in photoModels {
            allTags = allTags.union(aPhoto.separatedTags)
        }
        filterModels = allTags.map({ FilterObject(titleString: $0) }).sorted(by: { (m1, m2) -> Bool in
            return m1.title < m2.title
        })
    }
    
    
    private func filterCurrentResults() {
        
        let selectedFilters = filterModels.filter({ $0.isSelected })
        
        if selectedFilters.isEmpty {
            filteredPhotoModels = photoModels
        } else {
            let filterMap = selectedFilters.map({ $0.title })
            //TODO: add comment to explain logic
            filteredPhotoModels = photoModels.filter({ !(Set($0.separatedTags).intersection(Set(filterMap))).isEmpty })
        }
    }
    
    private func makeLocationBasedCall(locationCoOr: CLLocationCoordinate2D?) {
        
        guard let location = locationCoOr else {
            return
        }
        
        service.fetch(urlRequest: SearchRouter.searchWithLocation(latitude: location.latitude, longitude: location.longitude)) {[weak self] result in
            self?.handleFetchedResult(result: result)
        }
    }
    
    private func makeSearchCall(searchString: String) {
        
        guard !searchString.isEmpty else {
            return
        }
        
        service.fetch(urlRequest: SearchRouter.search(searchString: searchString)) { [weak self] (result) in
            
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
    
    func getModelForCellIndex(index: Int) -> PhotoCellViewModel? {
        
        return PhotoCellViewModel(photoModel: filteredPhotoModels[index])
    }
    
    func getModelForIndex(index: Int) -> PhotoObject? {
        guard index >= 0 && index < filteredPhotoModels.count else {
            return nil
        }
        return filteredPhotoModels[index]
    }
    
    func getFiltersVM() -> FiltersViewModel? {
        
        let viewModel = FiltersViewModel(allFilters: filterModels)
        viewModel.onFiltersUpdated = { [weak self] selectedFilters in
            self?.filterModels = selectedFilters
        }
        return viewModel
    }
    
    func getDetailViewModelForIndex(index: Int) -> PhotoDetailViewModel? {
        guard let model = getModelForIndex(index: index) else {
            return nil
        }
        return PhotoDetailViewModel(model: model)
    }
}

extension PhotoGridViewModel: LocationCallbackListener {
    
    func userLocationObtained(coordinates: CLLocationCoordinate2D) {
        print("fetched location is \(coordinates)")
        locationCoOr = coordinates
        locationManager.stopUpdatingLocation()
    }
    
    func locationPermissionDenied() {
        print("permission denied")
    }
    
    func locationPermissionGranted(status: CLAuthorizationStatus) {
        print("permission granted")
        locationManager.startUpdatingLocation()
    }
}
