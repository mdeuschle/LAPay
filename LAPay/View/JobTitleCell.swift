//
//  JobTitleCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/18/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class JobTitleCell: UITableViewCell {
    
    static let reuseIdentifier = "JobTitleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with payrolls: [Payroll], color: UIColor?, indexPath: IndexPath) {
        let payroll = payrolls[indexPath.row]
        textLabel?.text = payroll.job_class_title
        detailTextLabel?.text = payroll.total_payments?.dollars
        guard let color = color else { return }
        guard let cellColor = color.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(payrolls.count)) else { return }
        backgroundColor = cellColor
        textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cellColor, isFlat: true)
        detailTextLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cellColor, isFlat: true)
        tintColor = UIColor(contrastingBlackOrWhiteColorOn: cellColor, isFlat: true)
    }
}

