//
//  RootVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

class RootVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var color = UIColor.randomFlat
    
    private var departmentTitles = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var payrolls = [Payroll]() {
        didSet {
            self.departmentTitles = PayrollService.departmentTitles(for: payrolls)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Department Title"
        fetchPayrolls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        configureNavigationConroller()
        view.backgroundColor = .black
    }
    
    private func configureNavigationConroller() {
        navigationController?.navigationBar.barTintColor = color
        let contrastColor = ContrastColorOf(color, returnFlat: true)
        let textAttributes = [NSAttributedString.Key.foregroundColor: contrastColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    private func fetchPayrolls() {
        payrolls = Cache.loadPayrolls()
        if payrolls.isEmpty {
            refresh()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RootCell.self, forCellReuseIdentifier: RootCell.reuseIdentifier)
        tableView.backgroundColor = .black
    }
    
    @objc private func refresh() {
        let spinner = UIActivityIndicatorView(style: .gray)
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.startAnimating()
        PayrollStore.shared.fetchAll { json in
            DispatchQueue.main.async {
                if let payrolls = json {
                    self.payrolls = payrolls
                    Cache.archive(payrolls: payrolls)
                } else {
                    Alert(viewController: self).show()
                }
                spinner.stopAnimating()
            }
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootCell.reuseIdentifier, for: indexPath) as? RootCell else {
            return UITableViewCell()
        }
        let departmentTitle = departmentTitles[indexPath.row]
        cell.configure(with: departmentTitle, color: color, indexPath: indexPath)
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var filteredPayrolls = payrolls.filter { $0.department_title == departmentTitles[indexPath.row] }
        filteredPayrolls.sort { Double($0.total_payments!)! > Double($1.total_payments!)! }
        let jobTitleVC = JobTitleVC(payrolls: filteredPayrolls)
        navigationController?.pushViewController(jobTitleVC, animated: true)
    }
}

