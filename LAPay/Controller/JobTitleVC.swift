//
//  JobTitleVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/18/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

class JobTitleVC: UITableViewController {
    
    private var _payrolls = [Payroll]() {
        didSet {
            payrolls = _payrolls
        }
    }
    private var payrolls = [Payroll]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var color: Color?
    private var isFiltering = false
    
    private var filteredPayrolls = [Payroll]() {
        didSet {
            if isFiltering {
                payrolls = filteredPayrolls
            } else {
                payrolls = _payrolls
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        configureSearchBar()
    }
    
    init(payrolls: [Payroll], title: String, color: Color?) {
        super.init(style: .plain)
        self.payrolls = payrolls
        self.title = title
        self.color = color
        _payrolls = payrolls
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.setText(color: color?.dark.contrast ?? .white)
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        tableView.register(JobTitleCell.self, forCellReuseIdentifier: JobTitleCell.reuseIdentifier)
        tableView.backgroundColor = color?.dark
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payrolls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTitleCell.reuseIdentifier, for: indexPath) as? JobTitleCell else {
            return UITableViewCell()
        }
        cell.configure(with: payrolls, color: color?.base, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let payroll = payrolls[indexPath.row]
        let detailVC = DetailVC(payroll: payroll)
        detailVC.color = color
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension JobTitleVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.tintColor = color?.dark.contrast
        searchController.searchBar.setText(color: color?.dark.contrast ?? .white)
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            var _payrolls = [Payroll]()
            let filteredJobClassTitles = PayrollService.jobClassTitles(for: payrolls).filter {
                $0.lowercased().contains(text.lowercased())
            }
            filteredJobClassTitles.forEach { filteredJobClassTitle in
                var filteredPayrolls = payrolls.filter { $0.job_class_title == filteredJobClassTitle }
                filteredPayrolls.sort {
                    Double($0.total_payments ?? "") ?? 0.0 > Double($1.total_payments ?? "") ?? 0.0
                }
                _payrolls.append(filteredPayrolls.first!)
            }
            self.filteredPayrolls = _payrolls
        } else {
            isFiltering = false
            self.filteredPayrolls = [Payroll]()
        }
    }
}







