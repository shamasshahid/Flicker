//
//  LocationService.swift
//  Fickr
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

protocol LocationService {
    
    var locationCallbackListener: LocationCallbackListener? { get set }
    
    @discardableResult
    func requestAccess() -> LocationAccessRequestStatus
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
