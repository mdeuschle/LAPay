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
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(JobTitleCell.self, forCellReuseIdentifier: JobTitleCell.reuseIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTitleCell.reuseIdentifier, for: indexPath) as? JobTitleCell else {
            return UITableViewCell()
        }
        let payroll = payrolls[indexPath.row]
        cell.configure(with: payroll)
        return cell
    }
}


