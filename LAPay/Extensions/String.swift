//
//  String.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/18/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
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


