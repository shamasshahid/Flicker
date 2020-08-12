//
//  MockAPIService.swift
//  FickrTests
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

@testable import Fickr

class MockAPIService: APIService {
    
    var mockContentData: Data {
        return getData(name: "dummy")
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
    func fetch(urlRequest: APIRoutable, completionHandler: @escaping (Result<[PhotoObject], NetworkError>) -> Void) {
        let data = mockContentData
        if let response = try? JSONDecoder().decode(SearchResponseModel.self, from: data) {
            completionHandler(.success(response.photos.photo))
        }
    }
}
