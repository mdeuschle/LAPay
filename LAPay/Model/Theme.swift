//
//  ColorHelper.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/26/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Theme {
    static let shared = Theme()
    private init() {}
    
    private let colors: [Color] = [
        Color(title: "Red", base: .flatRed, dark: .flatRedDark),
        Color(title: "Orange", base: .flatOrange, dark: .flatOrangeDark),
        Color(title: "Yellow", base: .flatYellow, dark: .flatYellowDark)
    ]
    
    func getColors() -> [Color] {
        return colors
    }
}
