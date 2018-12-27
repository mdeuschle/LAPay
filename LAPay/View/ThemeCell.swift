//
//  ThemeCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/26/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class ThemeCell: UICollectionViewCell {
    
    weak var colorView: UIView!
    static var reuseIdentifier = "ThemeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let colorView = UIView(frame: .zero)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorView)
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        self.colorView = colorView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fatalError("Interface Builder is not supported!")
    }
}


