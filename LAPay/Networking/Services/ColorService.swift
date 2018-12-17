//
//  ColorService.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/16/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

struct ColorService {
    static let shared = ColorService()
    private init() {}
    let theme: [UIColor] = {
        if let colors =  NSArray(ofColorsWith: .analogous,
                                  using: UIColor.flatMint,
                                  withFlatScheme: true) as? [UIColor] {
            return colors
        }
        return [UIColor]()
    }()
}
