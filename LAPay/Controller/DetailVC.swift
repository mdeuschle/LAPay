//
//  DetailVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/2/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UITableViewController {
    
    private var payroll: Payroll!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = payroll.job_class_title
        configureTableView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    init(payroll: Payroll) {
        super.init(style: .plain)
        self.payroll = payroll
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payroll.payrollDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        let payrollDetail = payroll.payrollDetails[indexPath.row]
        cell.configure(with: payrollDetail, indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            showPDF()
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        showPDF()
    }
    
    private func showPDF() {
        let pdfView = PDFVC()
        pdfView.jobClassLink = payroll.job_class_link
        pdfView.view.backgroundColor = .white
        navigationController?.pushViewController(pdfView, animated: false)
    }
}
