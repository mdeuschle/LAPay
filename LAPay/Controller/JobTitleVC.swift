//
//  JobTitleVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/18/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class JobTitleVC: UITableViewController {
    
    private var payrolls = [Payroll]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        title = "Job Title & Total Earnings"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    init(payrolls: [Payroll]) {
        super.init(style: .plain)
        self.payrolls = payrolls
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(JobTitleCell.self, forCellReuseIdentifier: JobTitleCell.reuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payrolls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTitleCell.reuseIdentifier, for: indexPath) as? JobTitleCell else {
            return UITableViewCell()
        }
        let payroll = payrolls[indexPath.row]
        cell.configure(with: payroll)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let payroll = payrolls[indexPath.row]
        let detailVC = DetailVC(payroll: payroll)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}







