//
//  PhotoModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

struct PhotoModel: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let tags: String?
    let url_m: String?
    let url_o: String?
    
    var separatedTags: [String] {
        return tags != nil ? tags!.components(separatedBy: " ") : []
    }
}
