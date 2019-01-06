//
//  ColorExtension.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/6/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

extension Color {
    var contrast: UIColor {
        return ContrastColorOf(self.dark, returnFlat: true)
    }
}

