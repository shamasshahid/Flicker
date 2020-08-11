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
    
    func getURLString() -> String {
        return "https://farm\(model.farm).staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_m.png"
    }
    
    func getURL() -> URL? {
        return URL(string: getURLString())
    }
}
