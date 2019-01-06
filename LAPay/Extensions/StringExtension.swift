//
//  StringExtension.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/6/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

extension String {
    var dollars: String {
        let double = Double(self)
        let int = Int(double ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: int)) ?? ""
        return "$" + formattedNumber
    }
}

extension String {
    var percent: String? {
        if let _double = Double(self) {
            return "\(Int(_double * 10000))%"
        } else {
            return nil
        }
    }
}

