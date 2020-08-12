//
//  LocationManager.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationCallbackListener: class {
    func userLocationObtained(coordinates: CLLocationCoordinate2D)
    func locationPermissionDenied()
    func locationPermissionGranted(status: CLAuthorizationStatus)
}

/// describe status when `requestAccess` triggers
enum LocationAccessRequestStatus {
    /// `CLLocationManager` did send `requestAlwaysAuthorization` or `requestWhenInUseAuthorization`
    case sentAccessRequest
    
    /// user already denied access
    case alreadyDenied
    
    /// user already granted access
    case alreadyGranted
    
    /// unknown case
    case unknown
    
    /// location service is disabled
    case serviceDisabled
}

class LocationManager: NSObject, LocationService {
    
    private let locationManager = CLLocationManager()
    weak var locationCallbackListener: LocationCallbackListener?
    private var isFetchingLocation = false
    private var lastUserLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
    }
    
    @discardableResult
    func requestAccess() -> LocationAccessRequestStatus {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return .sentAccessRequest
            case .restricted, .denied:
                return .alreadyDenied
            case .authorizedAlways, .authorizedWhenInUse:
                startUpdatingLocation()
                return .alreadyGranted
            @unknown default:
                return .unknown
            }
        } else {
            return .serviceDisabled
        }
    }
    
    func startUpdatingLocation() {
        isFetchingLocation = true
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        isFetchingLocation = false
        locationManager.stopUpdatingLocation()
    }

    func isPermissionGranted() -> Bool {
        return (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
    }
    
    func userLocationCoordinates() -> CLLocationCoordinate2D? {
        lastUserLocation?.coordinate
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last, isFetchingLocation else { return }
        let horizontalAccuracy = userLocation.horizontalAccuracy
        if  horizontalAccuracy > 0 && horizontalAccuracy < 200 {
            stopUpdatingLocation()
            locationCallbackListener?.userLocationObtained(coordinates: userLocation.coordinate)
            lastUserLocation = userLocation
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .denied, .restricted:
            locationCallbackListener?.locationPermissionDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            locationCallbackListener?.locationPermissionGranted(status: status)
            startUpdatingLocation()
        @unknown default:
            locationCallbackListener?.locationPermissionDenied()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
