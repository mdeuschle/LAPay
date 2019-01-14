//
//  NavigationControllerExtension.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/13/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

extension UINavigationController {
    func configure(with color: Color?) {
        self.navigationBar.barTintColor = color?.dark
        let textAttributes = [NSAttributedString.Key.foregroundColor: color?.dark.contrast ?? .white]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.largeTitleTextAttributes = textAttributes
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        self.hidesNavigationBarHairline = true
        self.navigationBar.tintColor = color?.dark.contrast
    }
}
