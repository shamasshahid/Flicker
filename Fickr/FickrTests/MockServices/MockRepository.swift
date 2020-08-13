//
//  MockRepository.swift
//  FickrTests
//
//  Created by Shamas on 13/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import Fickr

class MockRepository: Repository {
    
    func getAPIService() -> APIService {
        return MockAPIService()
    }
    
    func getLocationService() -> LocationService {
        return MockLocationService()
    }
}
