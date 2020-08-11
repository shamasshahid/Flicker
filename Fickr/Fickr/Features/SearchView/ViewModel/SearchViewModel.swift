//
//  SearchViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    let service: APIService
    
    var dataRefreshed: (() -> Void)?
    
    var router: SearchRouter {
        didSet {
            
            guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "flickr_api_key") as? String, !apiKey.isEmpty else {
                fatalError("Flickr API Key Missing. Please put a valid key in AppConfiguration")
            }
            router.apiKey = apiKey
        }
    }
    
    var photoModels: [PhotoModel] = [] {
        didSet {
            generateFilterModels()
            
        }
    }
    
    var rowCount: Int {
        return filteredPhotoModels.count
    }
    
    var filteredPhotoModels: [PhotoModel] = [] {
        didSet {
            dataRefreshed?()
        }
    }
    
    var filterModels: [FilterModel] = [] {
        didSet {
            filterCurrentResults()
        }
    }
    
    func generateFilterModels() {
        var allTags = Set<String>()
        
        for aPhoto in photoModels {
            allTags = allTags.union(aPhoto.separatedTags)
        }
        filterModels = allTags.map({ FilterModel(titleString: $0) }).sorted(by: { (m1, m2) -> Bool in
            return m1.title < m2.title
        })
    }
    
    
    init(apiService: APIService, apiRouter: SearchRouter) {
        service = apiService
        router = apiRouter
    }
    
    func filterCurrentResults() {
        let selectedFilters = filterModels.filter({ $0.isSelected })
        if selectedFilters.isEmpty {
            filteredPhotoModels = photoModels
        } else {
            let filterMap = selectedFilters.map({ $0.title })
            filteredPhotoModels = photoModels.filter({ !(Set($0.separatedTags).intersection(Set(filterMap))).isEmpty })
        }
    }
    
    func makeSearchCall(searchString: String) {
        router.searchString = "mountain"
        
        service.fetch(urlRequest: router) {[weak self] (result) in
            switch result {
            case .success(let fetchedModels):
                self?.photoModels = fetchedModels
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchEntered(searchQuery: String) {
        router.searchString = searchQuery
    }
    
    func getModelForCellIndex(index: Int) -> PhotoCellViewModel? {
        
        return PhotoCellViewModel(photoModel: filteredPhotoModels[index])
    }
    
    func getFiltersVM() -> FiltersViewModel? {
        
        let viewmodel = FiltersViewModel(allFilters: filterModels)
        viewmodel.setSelectedModels = {[weak self] allSelectedFilters in
            self?.filterModels = allSelectedFilters
        }
        return viewmodel
    }
    
}
