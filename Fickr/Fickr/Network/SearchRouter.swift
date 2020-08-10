//
//  SearchRouter.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class SearchRouter: APIRoutable {
    
    var searchString: String = ""
    var apiKey: String = ""
    
    var queryItems: [String : Any] {
        return ["method": "flickr.photos.search",
                "api_key": apiKey,
                "text": searchString,
                "format" : "json",
                "nojsoncallback" : "1"]
    }
    
}
