//
//  RootCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/16/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

class RootCell: UITableViewCell {
    
    static let reuseIdentifier = "RootCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        accessoryType = .disclosureIndicator
        backgroundColor = .flatMint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with departmentTitles: [String], indexPath: IndexPath) {
        let departmentTitle = departmentTitles[indexPath.row]
        textLabel?.text = departmentTitle
    }
}

