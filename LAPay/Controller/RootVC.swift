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
    
    private var departmentTitles = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var payrolls = [Payroll]() {
        didSet {
            var departmentTitles = Set<String>()
            payrolls.forEach { payroll in
                if let departmentTitle = payroll.department_title {
                    departmentTitles.insert(departmentTitle)
                }
            }
            self.departmentTitles = Array(departmentTitles).sorted()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPayrolls()
    }
    
    private func fetchPayrolls() {
        payrolls = Cache.loadPayrolls()
        if payrolls.isEmpty {
            PayrollStore.shared.fetchAll { json in
                DispatchQueue.main.async {
                    if let payrolls = json {
                        self.payrolls = payrolls
                        Cache.archive(payrolls: payrolls)
                    } else {
                        Alert(viewController: self).show()
                    }
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
        return departmentTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath)
        let departmentTitle = departmentTitles[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = departmentTitle
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let jobTitleVC = JobTitleVC(nibName: "JobTitleVC", bundle: nil)
        var filteredPayrolls = payrolls.filter { $0.department_title == departmentTitles[indexPath.row] }
        filteredPayrolls.sort { Double($0.total_payments!)! > Double($1.total_payments!)! }
        jobTitleVC.payrolls = filteredPayrolls
        navigationController?.pushViewController(jobTitleVC, animated: true)
    }
}

