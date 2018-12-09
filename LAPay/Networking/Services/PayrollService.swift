//
//  PayrollService.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/9/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct PayrollService {
    static func departmentTitles(for payrolls: [Payroll]) -> [String] {
        var result = Set<String>()
        payrolls.forEach { payroll in
            if let departmentTitle = payroll.department_title {
                result.insert(departmentTitle)
            }
        }
        return Array(result).sorted()
    }
}

