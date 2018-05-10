//
//  DownloadService.swift
//  TestEncoding
//
//  Created by Jeremy Evans on 2018-05-09.
//  Copyright © 2018 Jeremy Evans. All rights reserved.
//

import Foundation

class DownloadService {
    
    static func fetchData(fromURL : URL, completion: @escaping (Data) -> Void) {
        let urlRequest = URLRequest(url: fromURL)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            completion(data!)
        })
        task.resume()
    }
}
