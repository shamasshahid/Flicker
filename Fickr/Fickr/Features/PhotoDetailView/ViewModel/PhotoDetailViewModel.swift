//
//  PhotoDetailViewModel.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
    
    private let dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    private let photoModel: PhotoObject
    private let dateFormatter = DateFormatter()
    
    enum PhotoDetailStrings: String {
        case viewNumber = "Views: %@"
        case viewNotAvailable = "Views: N/A"
        case dateTaken = "Date taken: %@"
        case dateTakenNotAvailable = "Date taken: N/A"
        case dateUploaded = "Date uploaded: %@"
        case dateUploadedNotAvailable = "Date uploaded: N/A"
        case size = "Size: %@ x %@"
        case sizeNotAvailable = "Size: N/A"
    }
    
    init(model: PhotoObject) {
        photoModel = model
    }
    
    var title: String {
        return photoModel.title
    }
    
    var originalURL: URL? {
        // sometimes original url is nil, in a last ditch effort trying medium
        return URL(string: photoModel.urlOriginal ?? photoModel.urlMedium ?? "")
    }
    
    var numberOfViewsText: String {
        if let views = photoModel.views {
            return String(format: NSLocalizedString(PhotoDetailStrings.viewNumber.rawValue, comment: ""), "\(views)")
        } else {
            return NSLocalizedString(PhotoDetailStrings.viewNotAvailable.rawValue, comment: "")
        }
    }
    
    var dateTakenText: String {
        if let dateString = photoModel.dateTaken, let formattedDate = getDateStringFromString(dateString: dateString) {
            return String(format: NSLocalizedString(PhotoDetailStrings.dateTaken.rawValue, comment: ""), "\(formattedDate)")
        } else {
            return NSLocalizedString(PhotoDetailStrings.dateTakenNotAvailable.rawValue, comment: "")
        }
    }
    
    private func getDateStringFromString(dateString: String) -> String? {
        
        dateFormatter.dateFormat = dateFormat
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    //TODO: move date logic to one method
    var dateUploadedText: String {
        if let interval = TimeInterval(photoModel.dateUploaded ?? "") {
            
            let date = Date(timeIntervalSince1970: interval)
            dateFormatter.dateStyle = .medium
            
            let dateString = dateFormatter.string(from: date)
            return String(format: NSLocalizedString(PhotoDetailStrings.dateUploaded.rawValue, comment: ""), "\(dateString)")
        } else {
            return NSLocalizedString(PhotoDetailStrings.dateUploadedNotAvailable.rawValue, comment: "")
        }
    }
    
    var imageDimensionsText: String {
        if let width = photoModel.originalWidth, let height = photoModel.originalHeight {
            return String(format: NSLocalizedString(PhotoDetailStrings.size.rawValue, comment: ""), "\(width)", "\(height)")
        } else {
            return NSLocalizedString(PhotoDetailStrings.sizeNotAvailable.rawValue, comment: "")
        }
    }
}

