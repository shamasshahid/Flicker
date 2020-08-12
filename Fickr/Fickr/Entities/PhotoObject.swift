//
//  PhotoModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

struct PhotoObject: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
    let tags: String?
    let urlMedium: String?
    let urlOriginal: String?
    let urlThumbnail: String?
    let views: String?
    let originalHeight: String?
    let originalWidth: String?
    let dateTaken: String?
    let dateUploaded: String?
    
    enum CodingKeys: String, CodingKey {
         case id
         case owner
         case secret
         case server
         case farm
         case title
         case isPublic = "ispublic"
         case isFriend = "isfriend"
         case isFamily = "isfamily"
         case tags
         case urlMedium = "url_m"
         case urlOriginal = "url_o"
         case urlThumbnail = "url_t"
         case views
         case originalHeight = "o_height"
         case originalWidth = "o_width"
         case dateTaken = "datetaken"
         case dateUploaded = "dateupload"
     }
    
    var separatedTags: [String] {
        return tags != nil ? tags!.components(separatedBy: " ") : []
    }
}
