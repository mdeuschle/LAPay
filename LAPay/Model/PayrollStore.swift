//
//  PayrollStore.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct PayrollStore {
    static let shared = PayrollStore()
    private init() {}
    func fetchAll(completion: @escaping ([Payroll]?) -> Void) {
        WebService.shared.dataSource(with: .none) { response in
            switch response {
            case let .success(data):
                if let json = try? JSONDecoder().decode([Payroll].self, from: data) {
                    completion(json)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}



