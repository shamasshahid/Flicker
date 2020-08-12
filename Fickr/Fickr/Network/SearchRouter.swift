//
//  SearchRouter.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

enum SearchRouter: APIRoutable {
    
    enum QueryItemsKeys: String {
        case method
        case apiKey = "api_key"
        case format
        case noJSONCallBack = "nojsoncallback"
        case extras
        case text
        case lat
        case lon
    }
    
    /// These values are taken from https://www.flickr.com/services/api/flickr.photos.search.html
    /// tags : fetches tags info
    /// url_m : Requests url for medium sized image
    /// url_o : Requests url for original sized image
    /// url_t : Requests url for thumbnail image
    /// date_upload : Requests the date that the image was uploaded
    /// date_taken : Requests the date the image was taken
    /// views : Requests number of views
    /// o_dims : Requests the original dimensions
    enum QueryItemsParams: String {
        case searchFunction  = "flickr.photos.search"
        case json
        case one = "1"
        case extraValues = "tags,url_m,url_o,url_t,date_upload,date_taken,views,o_dims"
        
    }
    
    case search(searchString: String)
    
    case searchWithLocation(latitude: Double, longitude: Double)
    
    var queryItems: [URLQueryItem] {
        var commonItems = [URLQueryItem(name: QueryItemsKeys.method.rawValue, value: QueryItemsParams.searchFunction.rawValue),
                           URLQueryItem(name: QueryItemsKeys.apiKey.rawValue, value: AppConfig.FLICKR_API_KEY),
                           URLQueryItem(name: QueryItemsKeys.format.rawValue, value: QueryItemsParams.json.rawValue),
                           URLQueryItem(name: QueryItemsKeys.noJSONCallBack.rawValue, value: QueryItemsParams.one.rawValue),
                           URLQueryItem(name: QueryItemsKeys.extras.rawValue, value: QueryItemsParams.extraValues.rawValue)]
        switch self {
        case .search(searchString: let searchString):
            commonItems.append(URLQueryItem(name: QueryItemsKeys.text.rawValue, value: searchString))
            return commonItems
        case .searchWithLocation(latitude: let lat, longitude: let lon):
            commonItems.append(URLQueryItem(name: QueryItemsKeys.lat.rawValue, value: String(lat)))
            commonItems.append(URLQueryItem(name: QueryItemsKeys.lon.rawValue, value: String(lon)))
            return commonItems
        }
    }
}
