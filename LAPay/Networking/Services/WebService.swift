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
    private let urlString = "https://controllerdata.lacity.org/resource/969q-4gr3.json"
    private init() {}
    
    func dataSource(completion: @escaping (Response<Data>) -> Void) {
        guard let url = URL(string: urlString) else {
            fatalError("Could not compose a valid URL in \(#file).\(#function)")}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
}
