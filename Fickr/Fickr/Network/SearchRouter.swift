//
//  SearchRouter.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

enum SearchRouter: APIRoutable {
    
    case search(searchString: String)
    
    case searchWithLocation(latitude: Double, longitude: Double)
    
    var queryItems: [URLQueryItem] {
        var commonItems = [URLQueryItem(name: "method", value: "flickr.photos.search"),
                           URLQueryItem(name: "api_key", value: AppConfig.FLICKR_API_KEY),
                           URLQueryItem(name: "format", value: "json"),
                           URLQueryItem(name: "nojsoncallback", value: "1"),
                           URLQueryItem(name: "extras", value: "tags,url_m,url_o,url_t,date_upload,date_taken,views,o_dims")]
        switch self {
        case .search(searchString: let searchString):
            commonItems.append(URLQueryItem(name: "text", value: searchString))
            return commonItems
        case .searchWithLocation(latitude: let lat, longitude: let lon):
            commonItems.append(URLQueryItem(name: "lat", value: String(lat)))
            commonItems.append(URLQueryItem(name: "lon", value: String(lon)))
            return commonItems
        }
    }
}
