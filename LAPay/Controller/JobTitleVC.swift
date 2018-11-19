//
//  JobTitleVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/18/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class JobTitleVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var payrolls = [Payroll]()
    
    private var sectionHeaders: [String] {
        let jobClassTitles = payrolls.compactMap { $0.job_class_title }
        return Array(Set(jobClassTitles)).sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension JobTitleVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionPayrolls = [Payroll]()
        for payroll in payrolls {
            if sectionHeaders[section] == payroll.job_class_title {
                sectionPayrolls.append(payroll)
            }
        }
        return sectionPayrolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let payroll = payrolls[indexPath.row]
        cell.textLabel?.text = payroll.total_payments
        return cell
    }
}


