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
    
    private func urlString() -> String {
        let base = "https://controllerdata.lacity.org/resource/969q-4gr3.json?$where=total_payments>80000.00&$limit=50000&year="
        let date = Date()
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "date")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        let previousYearInt = (Int(year) ?? 2019) - 1
        return base + "\(previousYearInt)"
    }
    
    private func components(from urlString: String) -> URLComponents? {
        guard let path = urlString.components(separatedBy: "?").first else { return nil }
        var components = URLComponents(string: path)
        if let queryString = urlString.components(separatedBy: "?").last {
            components?.queryItems = []
            let queryItems = queryString.components(separatedBy: "&")
            for queryItem in queryItems {
                guard let name = queryItem.components(separatedBy: "=").first,
                    let value = queryItem.components(separatedBy: "=").last else {
                        continue
                }
                components?.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        return components
    }
    
    func dataSource(completion: @escaping (Response<Data>) -> Void) {
        let components = self.components(from: urlString())
        guard let url = components?.url else {
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
