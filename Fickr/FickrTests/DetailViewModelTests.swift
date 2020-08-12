//
//  DetailViewModelTests.swift
//  FickrTests
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest
@testable import Fickr

class DetailViewModelTests: XCTestCase {

    var detailViewModel: PhotoDetailViewModel!
    var objectWithEmptyAttributes: PhotoObject!
    var object: PhotoObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        object = PhotoObject(id: "50215731483", owner: "24083365", secret: "539b102771", server: "65535", farm: 66, title: "Mountain Bluebird", isPublic: 1, isFriend: 0, isFamily: 0, tags: "bird nature wildlife ornithology saskatchewan pamhawkes", urlMedium: "https://live.staticflickr.com/65535/50216584631_be8af04ecb.jpg", urlOriginal: "https://live.staticflickr.com/65535/50216584631_3fd354ab3f_o.jpg", urlThumbnail: "https://live.staticflickr.com/65535/50216584631_be8af04ecb_t.jpg", views: "100", originalHeight: "3795", originalWidth: "5092", dateTaken: "2020-08-10 04:32:11", dateUploaded: "1597194066")
        
        objectWithEmptyAttributes = PhotoObject(id: "123423", owner: "12343", secret: "539b102771", server: "65535", farm: 66, title: "test Title", isPublic: 1, isFriend: 0, isFamily: 0, tags: "", urlMedium: nil, urlOriginal: nil, urlThumbnail: nil, views: nil, originalHeight: nil, originalWidth: nil, dateTaken: nil, dateUploaded: nil)
        detailViewModel = PhotoDetailViewModel(model: object)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        object = nil
        detailViewModel = nil
        
    }

    func testDetailViewModel() throws {
//        dateTakenLabel.text = viewModel.dateTakenText
//        dateUploadedLabel.text = viewModel.dateUploadedText
        XCTAssertEqual(detailViewModel.title, object.title, "Titles should match")
        XCTAssertEqual(detailViewModel.numberOfViewsText, "Views: \(object.views!)")
        XCTAssertEqual(detailViewModel.imageDimensionsText, "Size: \(object.originalWidth!) x \(object.originalHeight!)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let interval = TimeInterval(object.dateUploaded ?? "")!
        let date = Date(timeIntervalSince1970: interval)
        dateFormatter.dateStyle = .medium
        XCTAssertEqual(detailViewModel.dateUploadedText, "Date uploaded: \(dateFormatter.string(from: date))")
        
        let dateTaken = object.dateTaken!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.date(from: dateTaken)!
        dateFormatter.dateStyle = .medium
        XCTAssertEqual(detailViewModel.dateTakenText, "Date taken: \(dateFormatter.string(from: formattedDate))")
        
        XCTAssertEqual(detailViewModel.originalURL, URL(string: object.urlOriginal ?? ""))
    }
    
    func testDetaiViewModelWithEmptyAttributes() throws {
        detailViewModel = PhotoDetailViewModel(model: objectWithEmptyAttributes)
        
        XCTAssertEqual(detailViewModel.numberOfViewsText, "Views: N/A")
        XCTAssertEqual(detailViewModel.dateTakenText, "Date taken: N/A")
        XCTAssertEqual(detailViewModel.dateUploadedText, "Date uploaded: N/A")
        XCTAssertEqual(detailViewModel.imageDimensionsText, "Size: N/A")
        
        XCTAssertNil(detailViewModel.originalURL)
    }
}
