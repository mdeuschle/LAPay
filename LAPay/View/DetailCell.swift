//
//  DetailCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static let reuseIdentifier = "DetailCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with payrollDetail: PayrollDetail, indexPath: IndexPath) {
        accessoryType = indexPath.row == 0 ? .detailButton : .none
        selectionStyle = indexPath.row == 0 ? .default : .none
        textLabel?.text = payrollDetail.title
        detailTextLabel?.text = payrollDetail.value
    }
}
