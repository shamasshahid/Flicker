//
//  SearchService.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class SearchService: APIService {
    
    let session = URLSession.shared
    
    func fetch(urlRequest: APIRoutable, completionHandler: @escaping (Result<[PhotoModel], NetworkError>) -> Void) {
        
        do {
            let task = try session.dataTask(with: urlRequest.asURLRequest(), completionHandler: { (dataResponse, responseObject, error) in
                
                guard let data = dataResponse else {
                    completionHandler(.failure(error as! NetworkError))
                    return
                }
                guard let response = try? JSONDecoder().decode(SearchResponseModel.self, from: data) else{
                    completionHandler(.failure(.invalidParseStructure))
                    return
                }
                completionHandler(.success(response.photos.photo))
            })
            task.resume()
        } catch {
            completionHandler(.failure(.badURL))
        }
        
    }
}
