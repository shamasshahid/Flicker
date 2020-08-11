//
//  ImageCellViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class PhotoCellViewModel {
    
    let model: PhotoModel
    
    init(photoModel: PhotoModel) {
        model = photoModel
    }
//    let id: String
//    let owner: String
//    let secret: String
//    let server: String
//    let farm: Int
//    let title: String
//    let ispublic: Int
//    let isfriend: Int
//    let isfamily: Int
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
    
    func getURLString() -> String {
        return "https://farm\(model.farm).staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_m.png"
    }
    
    func getURL() -> URL? {
        return URL(string: getURLString())
    }
}
