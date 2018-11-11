//
//  WebService.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct WebService: DataSource {
    static let shared = WebService()
    private init() {}
    
    func dataSource(with endpoint: Endpoint, completion: @escaping (Response<Data>) -> Void) {
        let _url = url(for: endpoint)
        let task = URLSession.shared.dataTask(with: _url) { data, _, error in
            let response: Response<Data>
            if let data = data {
                response = .success(data)
            } else {
                response = .failure(error)
            }
            completion(response)
        }
        task.resume()
    }
    
    func url(for endpoint: Endpoint) -> URL {
        let path: String
        let base = "https://controllerdata.lacity.org/resource/k8wm-a9xd.json"
        switch endpoint {
        case .departmentTitle:
            path = base
        }
        guard let url = URL(string: path) else {
            fatalError("Could not compose a valid URL in \(#file).\(#function)")
        }
        return url
    }
}
