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
    
    private var payrolls = [Payroll]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        title = "Title & Total Payments"
    }
    
    init(payrolls: [Payroll]) {
        super.init(nibName: "JobTitleVC", bundle: nil)
        self.payrolls = payrolls
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JobTitleCell.self, forCellReuseIdentifier: JobTitleCell.reuseIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTitleCell.reuseIdentifier, for: indexPath) as? JobTitleCell else {
            return UITableViewCell()
        }
        let payroll = payrolls[indexPath.row]
        cell.configure(with: payroll)
        return cell
    }
}

extension JobTitleVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payroll = payrolls[indexPath.row]
        let detailVC = DetailVC(payroll: payroll)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


