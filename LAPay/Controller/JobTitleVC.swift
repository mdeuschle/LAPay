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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension JobTitleVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payrolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let payroll = payrolls[indexPath.row]
        cell.textLabel?.text = payroll.total_payments
        return cell
    }
}
