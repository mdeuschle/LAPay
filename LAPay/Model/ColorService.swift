//
//  ColorService.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/27/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

struct ColorService {
    static let shared = ColorService()
    private init() {}
    
    var all: [Color] = [
        Color(title: "Red", base: .flatRed, dark: .flatRedDark),
        Color(title: "Orange", base: .flatOrange, dark: .flatOrangeDark),
        Color(title: "Yellow", base: .flatYellow, dark: .flatYellowDark),
        Color(title: "Sand", base: .flatSand, dark: .flatSandDark),
        Color(title: "Navy Blue", base: .flatNavyBlue, dark: .flatNavyBlueDark),
        Color(title: "Black", base: .flatBlack, dark: .flatBlack),
        Color(title: "Magenta", base: .flatMagenta, dark: .flatMagentaDark),
        Color(title: "Teal", base: .flatTeal, dark: .flatTealDark),
        Color(title: "Sky Blue", base: .flatSkyBlue, dark: .flatSkyBlueDark),
        Color(title: "Green", base: .flatGreen, dark: .flatGreenDark),
        Color(title: "Mint", base: .flatMint, dark: .flatMintDark),
        Color(title: "White", base: .flatWhite, dark: .flatWhiteDark),
        Color(title: "Gray", base: .flatGray, dark: .flatGrayDark),
        Color(title: "Forest Green", base: .flatForestGreen, dark: .flatForestGreenDark),
        Color(title: "Purple", base: .flatPurple, dark: .flatPurpleDark),
        Color(title: "Brown", base: .flatBrown, dark: .flatBrownDark),
        Color(title: "Plum", base: .flatPlum, dark: .flatPlumDark),
        Color(title: "Watermelon", base: .flatWatermelon, dark: .flatWatermelonDark),
        Color(title: "Lime", base: .flatLime, dark: .flatLimeDark),
        Color(title: "Pink", base: .flatPink, dark: .flatPinkDark),
        Color(title: "Maroon", base: .flatMaroon, dark: .flatMaroonDark),
        Color(title: "Coffee", base: .flatCoffee, dark: .flatCoffeeDark),
        Color(title: "Powder Blue", base: .flatPowderBlue, dark: .flatPowderBlueDark),
        Color(title: "Blue", base: .flatBlue, dark: .flatBlueDark)
    ]
}
