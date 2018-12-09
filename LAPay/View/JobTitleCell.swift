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
        textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with payroll: Payroll) {
        let jobClassTitle = payroll.job_class_title ?? ""
        let totalPayments = payroll.total_payments ?? ""
        textLabel?.text = jobClassTitle
        detailTextLabel?.text = "\(totalPayments.dollars)"
    }
}
