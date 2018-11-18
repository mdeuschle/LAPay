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
    
    private var jobClassTitles = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var payrolls = [Payroll]() {
        didSet {
            var jobClassTitles = Set<String>()
            payrolls.forEach { payroll in
                if let jobClassTitle = payroll.job_class_title {
                    jobClassTitles.insert(jobClassTitle)
                }
            }
            self.jobClassTitles = Array(jobClassTitles).sorted()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPayrolls()
    }
    
    private func fetchPayrolls() {        
        if payrolls.isEmpty {
            PayrollStore.shared.fetchAll { json in
                DispatchQueue.main.async {
                    if let payrolls = json {
                        self.payrolls = payrolls
                        Cache.archive(payrolls: payrolls)
                    } else {
                        // TODO POPUP
                        print("DOWNLOAD ERROR")
                    }
                }
            }
        } else {
            self.payrolls = Cache.loadPayrolls()
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
        return jobClassTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let jobClassTitle = jobClassTitles[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = jobClassTitle
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
    }
}
