//
//  Color.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/26/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Color {
    let title: String
    let base: UIColor
    let dark: UIColor
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case base
        case dark
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        let baseColorData = try container.decode(Data.self, forKey: .base)
        base = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(baseColorData) as? UIColor ?? .black
        let darkColorData = try container.decode(Data.self, forKey: .dark)
        dark = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(darkColorData) as? UIColor ?? .black
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        let baseColorData = try NSKeyedArchiver.archivedData(withRootObject: base, requiringSecureCoding: false)
        try container.encode(baseColorData, forKey: .base)
        let darkColorData = try NSKeyedArchiver.archivedData(withRootObject: dark, requiringSecureCoding: false)
        try container.encode(darkColorData, forKey: .dark)
    }
}

extension Color {
    var contrast: UIColor {
        return ContrastColorOf(self.dark, returnFlat: true)
    }
}


