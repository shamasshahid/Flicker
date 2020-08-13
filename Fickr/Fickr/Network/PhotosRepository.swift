//
//  DependencyRepository.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

protocol Repository {
    func getAPIService() -> APIService
    func getLocationService() -> LocationService
}

class PhotosRepository: Repository {
    func getAPIService() -> APIService {
        return SearchService()
    }
    
    func getLocationService() -> LocationService {
        return LocationManager()
    }
}
