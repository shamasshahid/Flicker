//
//  PhotoDetailViewModel.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
        
    private let photoModel: PhotoObject
    
    // We shouldn't separate some of the prefixes (Date uploaded), since their place in some languages might not be a prefix at all
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
        guard let views = photoModel.views else {
            return NSLocalizedString(PhotoDetailStrings.viewNotAvailable.rawValue, comment: "")
        }
        
        return String(format: NSLocalizedString(PhotoDetailStrings.viewNumber.rawValue, comment: ""), "\(views)")
    }
    
    // API returns dateTaken in a "2020-08-10 04:32:11" format
    // first we make a date out of it, and then show it as a medium style format
    var dateTakenText: String {
        guard let dateString = photoModel.dateTaken, let date = DateFormatter.longDateFormatReader.date(from: dateString) else {
            return NSLocalizedString(PhotoDetailStrings.dateTakenNotAvailable.rawValue, comment: "")
        }
        
        let formattedDate = DateFormatter.mediumDateStringFormatter.string(from: date)
        return String(format: NSLocalizedString(PhotoDetailStrings.dateTaken.rawValue, comment: ""), "\(formattedDate)")
    }
    
    // API returns dateUploaded as timestamp "1597194066". First make a date object, then the formatted text
    var dateUploadedText: String {
        
        guard let interval = TimeInterval(photoModel.dateUploaded ?? "") else {
            return NSLocalizedString(PhotoDetailStrings.dateUploadedNotAvailable.rawValue, comment: "")
        }
        
        let date = Date(timeIntervalSince1970: interval)
        let dateString = DateFormatter.mediumDateStringFormatter.string(from: date)
        return String(format: NSLocalizedString(PhotoDetailStrings.dateUploaded.rawValue, comment: ""), "\(dateString)")
    }
        
    // dimensions are shown as 'width x height' format i.e 1600 x 1200
    var imageDimensionsText: String {
        guard let width = photoModel.originalWidth, let height = photoModel.originalHeight else {
            return NSLocalizedString(PhotoDetailStrings.sizeNotAvailable.rawValue, comment: "")
        }
        
        return String(format: NSLocalizedString(PhotoDetailStrings.size.rawValue, comment: ""), "\(width)", "\(height)")
    }
}

