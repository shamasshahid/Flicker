//
//  ImageCellViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class PhotoCellViewModel {
    
    let model: PhotoObject
    
    init(photoModel: PhotoObject) {
        model = photoModel
    }
    
    func getURL() -> URL? {
        return model.urlThumbnail == nil ? nil : URL(string: model.urlThumbnail ?? "")
    }
}
