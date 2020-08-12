//
//  AppConfig.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class AppConfig {
    
    static var FLICKR_API_KEY: String {
        guard let fetchKey = Bundle.main.object(forInfoDictionaryKey: "flickr_api_key") as? String, !fetchKey.isEmpty else {
            fatalError("Flickr API Key Missing. Please put a valid key in AppConfiguration")
        }
        return fetchKey
    }
    
}
