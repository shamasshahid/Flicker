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
    
    var dataRefreshed: (()-> Void)?
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
            dataRefreshed?()
        }
    }
    
    init(apiService: APIService, apiRouter: SearchRouter) {
        
        service = apiService
        router = apiRouter
        
    }
    
    func makeSearchCall() {
        
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
    
}
