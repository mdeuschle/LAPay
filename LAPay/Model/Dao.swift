//
//  File.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/29/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Dao {
    
    let payrollDirectory: URL
    let colorDirectory: URL
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        payrollDirectory = paths[0].appendingPathComponent("/payroll")
        colorDirectory = paths[0].appendingPathComponent("/color")
    }
    
    func archive(payrolls: [Payroll]) {
        guard let data = try? PropertyListEncoder().encode(payrolls) else { return }
        try? data.write(to: payrollDirectory)
    }
    
    func unarchivePayrolls() -> [Payroll]? {
        guard let data = try? Data(contentsOf: payrollDirectory) else { return nil }
        return try? PropertyListDecoder().decode([Payroll].self, from: data)
    }
    
    func archive(color: Color) {
        guard let data = try? PropertyListEncoder().encode(color) else { return }
        try? data.write(to: colorDirectory)
    }
    
    func unarchiveColor() -> Color? {
        guard let data = try? Data(contentsOf: colorDirectory) else { return nil }
        return try? PropertyListDecoder().decode(Color.self, from: data)
    }
}




