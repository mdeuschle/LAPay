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
    
    private var urlString: String = {
        let base = "https://controllerdata.lacity.org/resource/969q-4gr3.json?$limit=100000&year="
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        let previousYearInt = (Int(year) ?? 2019) - 1
        return base + "\(previousYearInt)"
    }()
    
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
