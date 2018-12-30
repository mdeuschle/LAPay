//
//  DetailVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/2/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework
import PDFKit

class DetailVC: UITableViewController {
    
    private var payroll: Payroll!
    var color: UIColor?

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
        tableView.backgroundColor = color
        tableView.separatorStyle = .none
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payroll.payrollDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        cell.configure(with: payroll.payrollDetails, color: color, indexPath: indexPath)
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
        guard let jobClassLink = payroll.job_class_link,
        let url = URL(string: jobClassLink),
            let document = PDFDocument(url: url) else {
                Alert(viewController: self).show(message: .noDescription)
                return
        }
        let pdfVC = PDFVC()
        pdfVC.document = document
        pdfVC.color = color
        navigationController?.pushViewController(pdfVC, animated: false)
    }
}
