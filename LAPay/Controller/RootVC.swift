//
//  RootVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var payrolls = [Payroll]() {
        didSet {
            tableView.reloadData()
            print("COUNT: \(payrolls.count)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPayrolls()
    }
    
    private func fetchPayrolls() {
        PayrollStore.shared.fetchAll { json in
            DispatchQueue.main.async {
                if let payrolls = json {
                    self.payrolls = payrolls
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RootVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payrolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let payroll = payrolls[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = payroll.job_class_title
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
    }
}
