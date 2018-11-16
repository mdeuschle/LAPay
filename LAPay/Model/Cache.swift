//
//  Cache.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Cache {
    
    private static let fileExtension = "LAPay"
    
    private static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: [.userDomainMask])[0]
    }
    
    private static func archivePath() -> URL {
        return documentsDirectory.appendingPathComponent("\(fileExtension)")
    }
    
    static func archive(payrolls: [Payroll]) {
        let path = archivePath()
        do {
            let jsonData = try JSONEncoder().encode(payrolls)
            let data = try NSKeyedArchiver.archivedData(withRootObject: jsonData, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print("Archive error \(error)")
        }
    }
    
    static func loadPayrolls() -> [Payroll] {
        var payrolls = [Payroll]()
        do {
            let data = try Data(contentsOf: archivePath())
            let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! Data
            let json = try JSONDecoder().decode([Payroll].self, from: unarchivedData)
            payrolls = json
        } catch {
            print("Unarchive error \(error)")
        }
        return payrolls
    }
}

