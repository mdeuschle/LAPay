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
        return Array(Set(payrolls.compactMap { $0.department_title })).sorted()
    }
    static func jobClassTitles(for payrolls: [Payroll]) -> [String] {
        return payrolls.compactMap { $0.job_class_title }.sorted()
    }
}



