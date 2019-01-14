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
    
    private var payrolls = [Payroll]() 
    private var filteredPayrolls = [Payroll]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var isFiltering = false
    private var color: Color?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.setText(color: color?.dark.contrast ?? .white)
        searchController.searchBar.tintColor = color?.dark.contrast
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        tableView.register(JobTitleCell.self, forCellReuseIdentifier: JobTitleCell.reuseIdentifier)
        tableView.backgroundColor = color?.dark
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPayrolls.count
        } else {
            return payrolls.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTitleCell.reuseIdentifier, for: indexPath) as? JobTitleCell else {
            return UITableViewCell()
        }
        if isFiltering {
            cell.configure(with: filteredPayrolls, color: color?.base, indexPath: indexPath)
        } else {
            cell.configure(with: payrolls, color: color?.base, indexPath: indexPath)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let payroll: Payroll
        if isFiltering {
            payroll = filteredPayrolls[indexPath.row]
        } else {
            payroll = payrolls[indexPath.row]
        }
        let detailVC = DetailVC(payroll: payroll)
        detailVC.color = color
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension JobTitleVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.setText(color: color?.dark.contrast ?? .white)
        searchController.searchBar.tintColor = color?.dark.contrast
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            filteredPayrolls = payrolls.filter {
                $0.job_class_title?.lowercased().contains(text.lowercased()) ?? false
            }
            filteredPayrolls.sort {
                Double($0.total_payments ?? "") ?? 0.0 > Double($1.total_payments ?? "") ?? 0.0
            }
        } else {
            isFiltering = false
            tableView.reloadData()
        }
    }
}







