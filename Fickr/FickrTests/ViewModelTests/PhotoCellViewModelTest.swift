//
//  PhotoCellViewModelTest.swift
//  FickrTests
//
//  Created by Shamas on 13/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import Fickr

class PhotoCellViewModelTest: XCTestCase {

    var photoCellViewModel: PhotoCellViewModel!
    override func setUpWithError() throws {
        
        let photoObject = getPhotoObject(shouldHaveURL: true)
        photoCellViewModel = PhotoCellViewModel(photoModel: photoObject)
    }

    override func tearDownWithError() throws {
        
        photoCellViewModel = nil
    }
    
    func testGetURL() {
        
        XCTAssertNotNil(photoCellViewModel.getURL(), "Thumbnail url should not be nil")
        
        photoCellViewModel = PhotoCellViewModel(photoModel: getPhotoObject(shouldHaveURL: false))
        
        XCTAssertNil(photoCellViewModel.getURL())
    }
    
    
    
    func getPhotoObject(shouldHaveURL: Bool) -> PhotoObject {
        let thumbnailURL = shouldHaveURL ? "https://live.staticflickr.com/65535/50216584631_be8af04ecb_t.jpg" : nil
        let photoObject = PhotoObject(id: "50215731483", owner: "24083365", secret: "539b102771", server: "65535", farm: 66, title: "Mountain Bluebird", isPublic: 1, isFriend: 0, isFamily: 0, tags: "bird nature wildlife ornithology saskatchewan pamhawkes", urlMedium: "https://live.staticflickr.com/65535/50216584631_be8af04ecb.jpg", urlOriginal: "https://live.staticflickr.com/65535/50216584631_3fd354ab3f_o.jpg", urlThumbnail: thumbnailURL, views: "100", originalHeight: "3795", originalWidth: "5092", dateTaken: "2020-08-10 04:32:11", dateUploaded: "1597194066")
        return photoObject
    }
}
