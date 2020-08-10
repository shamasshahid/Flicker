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
    
    func getURLRouter() -> APIRoutable
}

class DependencyRepository: Repository {
    
    func getService() -> APIService {
        return SearchService()
    }
    
    func getURLRouter() -> APIRoutable {
        
        return SearchRouter()
    }

}
