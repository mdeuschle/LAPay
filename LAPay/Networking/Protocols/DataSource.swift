//
//  DataSource.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

protocol DataSource {
    static func dataSource(with endpoint: Endpoint, completion: @escaping (Response<Data>) -> Void)
    static func url(for endpoint: Endpoint) -> URL?
}
