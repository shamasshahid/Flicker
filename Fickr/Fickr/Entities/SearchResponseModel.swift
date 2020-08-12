//
//  SearchResponseModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

struct SearchResponseModel: Codable {
    let photos: PhotosResponse
}

struct PhotosResponse: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: String
    let photo: [PhotoObject]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "perpage"
        case total
        case photo
    }
}

