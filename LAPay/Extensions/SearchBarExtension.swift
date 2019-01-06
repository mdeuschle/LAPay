//
//  SearchBarExtension.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/6/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setText(color: UIColor) {
        let viewSubviews = subviews.compactMap { $0.subviews }.first
        guard let searchTextField = (viewSubviews?.filter { $0 is UITextField })?.first as? UITextField else { return }
        searchTextField.textColor = color
    }
}
