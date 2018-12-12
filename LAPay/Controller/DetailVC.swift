//
//  DetailVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/2/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var payroll: Payroll!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        configureTableView()
    }
    
    init(payroll: Payroll) {
        super.init(nibName: "DetailVC", bundle: nil)
        self.payroll = payroll
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
    }
}

extension DetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payroll.payrollDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        let payrollDetail = payroll.payrollDetails[indexPath.row]
        cell.configure(with: payrollDetail, indexPath: indexPath)
        return cell
    }
}

extension DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let pdfView = PDFVC()
        pdfView.jobClassLink = payroll.job_class_link
        navigationController?.pushViewController(pdfView, animated: false)
        print(pdfView.jobClassLink)
    }
}
