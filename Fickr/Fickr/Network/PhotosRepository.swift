//
//  DependencyRepository.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

protocol Repository {
    func getService() -> APIService
}

class PhotosRepository: Repository {
    func getService() -> APIService {
        return SearchService()
    }
}
