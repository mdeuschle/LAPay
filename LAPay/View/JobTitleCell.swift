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
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with payroll: Payroll) {
        self.textLabel?.text = "Total Payments: \(payroll.total_payments?.dollars ?? "")"
        self.detailTextLabel?.text = "Year: \(payroll.year ?? "")"
    }
}
