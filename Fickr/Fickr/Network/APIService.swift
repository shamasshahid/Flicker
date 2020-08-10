//
//  APIService.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidParseStructure
}

protocol APIService {
    
    func fetch(urlRequest: APIRoutable, completionHandler: @escaping (Result<[PhotoModel], NetworkError>) -> Void)
}
