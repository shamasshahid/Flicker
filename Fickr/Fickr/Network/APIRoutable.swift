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
    var queryItems: [String: Any] {get}
    func asURLRequest() throws -> URLRequest
}

public enum RoutableError : Error{
    case invalidRoute
}

public extension APIRoutable{
    
    var baseURL : String {
        return "https://www.flickr.com"
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
    
    var queryItems: [String: Any] {
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest
    {
        var queryString = ""
        for queryO in queryItems where !queryItems.isEmpty {
            if queryString.isEmpty {
                queryString.append("?")
            } else {
                queryString.append("&")
            }
            queryString.append("\(queryO.key)=\(queryO.value)")
        }
        
        guard let url = URL(string: baseURL+path+queryString) else{
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
