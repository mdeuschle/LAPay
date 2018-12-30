//
//  ThemeCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/27/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    @IBOutlet weak var colorContainer: UIView!
    @IBOutlet weak var baseColorView: UIView!
    @IBOutlet weak var darkColorView: UIView!
    @IBOutlet weak var colorTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        colorContainer.layer.cornerRadius = colorContainer.frame.width / 2
        colorContainer.clipsToBounds = true
    }

    func configure(with color: Color) {
        baseColorView.backgroundColor = color.base
        darkColorView.backgroundColor = color.dark
        colorTitle.text = color.title
    }
}
