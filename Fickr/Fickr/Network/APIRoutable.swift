//
//  APIRoutable.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

public enum HttpMethod : String
{
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol APIRoutable {
    var baseURL : String {get}
    var path : String {get}
    var httpMethod : HttpMethod {get}
    var headers : [String:Any] {get}
    var queryItems: [URLQueryItem] {get}
    func asURLRequest() throws -> URLRequest
}

public enum RoutableError : Error{
    case invalidRoute
}

public extension APIRoutable{
    
    var baseURL : String {
        return "www.flickr.com"
    }
    
    var path : String {
        return "/services/rest/"
    }
    
    var httpMethod: HttpMethod {
        return HttpMethod.GET
    }
    
    var headers : [String:Any] {
        return [:]
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    func asURLRequest() throws -> URLRequest
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else{
            throw RoutableError.invalidRoute
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for headerField in headers.keys {
            request.setValue(headers[headerField] as? String, forHTTPHeaderField: headerField)
        }
        
        return request
    }
}
