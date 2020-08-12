//
//  MockLocationService.swift
//  FickrTests
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Fickr

class MockLocationService: LocationService {
    var locationCallbackListener: LocationCallbackListener?
    
    func requestAccess() -> LocationAccessRequestStatus {
        //TODO: add resaons, should not use main queue
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.locationCallbackListener?.locationPermissionGranted(status: .authorizedWhenInUse)
        }
        return .alreadyGranted
    }
    
    func startUpdatingLocation() {
        locationCallbackListener?.userLocationObtained(coordinates: CLLocationCoordinate2D(latitude: 0.423, longitude: 0.423))
    }
    
    func stopUpdatingLocation() {
    }
}
