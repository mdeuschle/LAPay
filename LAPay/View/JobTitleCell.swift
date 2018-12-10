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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with payroll: Payroll) {
        accessoryType = .disclosureIndicator
        textLabel?.text = payroll.job_class_title
        detailTextLabel?.text = payroll.total_payments?.dollars
    }
    
    func configure(with payrollDetail: PayrollDetail) {
        accessoryType = .none
        textLabel?.text = payrollDetail.title
        detailTextLabel?.text = payrollDetail.value
    }
}
