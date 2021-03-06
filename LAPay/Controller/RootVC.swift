//
//  RootVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import ChameleonFramework

class RootVC: UIViewController, ThemeDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    private var payrolls = [Payroll]()
    private var departmentTitles = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var color: Color? {
        didSet {
            navigationController?.configure(with: color)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Department Title"
        fetchPayrolls()
        loadColor()
        refreshIfNeeded()
        configureSearchBar()
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        configureBarButtons()
        view.backgroundColor = color?.dark
        self.setStatusBarStyle(UIStatusBarStyleContrast)
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
    
    private func configureBarButtons() {
        let themButton = UIBarButtonItem(title: "Theme",
                                         style: .done,
                                         target: self,
                                         action: #selector(themeButtonTapped))
        navigationItem.rightBarButtonItem = themButton
        let infoButton = UIBarButtonItem(title: "Info",
                                         style: .plain,
                                         target: self,
                                         action: #selector(infoButtonTapped))
        navigationItem.leftBarButtonItem = infoButton
    }
    
    @objc private func themeButtonTapped() {
        let themeVC = ThemeVC(delegate: self)
        navigationController?.pushViewController(themeVC, animated: true)
    }
    
    @objc private func infoButtonTapped() {
        let infoVC = InfoVC(color: color, payroll: payrolls.first)
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    private func loadColor() {
        color = Dao().unarchiveColor() ?? Color(title: "Mint",
                                                base: .flatMint,
                                                dark: .flatMintDark)
    }
    
    func choose(color: Color) {
        self.color = color
        Dao().archive(color: color)
    }
    
    private func fetchPayrolls() {
        payrolls = Dao().unarchivePayrolls() ?? [Payroll]()
        departmentTitles = PayrollService.departmentTitles(for: payrolls)
        if payrolls.isEmpty { refresh() }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RootCell.self, forCellReuseIdentifier: RootCell.reuseIdentifier)
        tableView.backgroundColor = color?.dark
    }
    
    private func refreshIfNeeded() {
        let userDefaults = UserDefaults.standard
        if let setDate = userDefaults.object(forKey: "date") as? Date {
            let currentDate = Date()
            if let refreshDate = Calendar.current.date(byAdding: .month, value: 6, to: setDate) {
                if currentDate > refreshDate {
                    payrolls = [Payroll]()
                    refresh()
                }
            }
        }
    }
    
    @objc private func refresh() {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.startAnimating()
        PayrollStore.shared.fetchAll { json in
            DispatchQueue.main.async {
                if let payrolls = json {
                    self.payrolls = payrolls
                    self.departmentTitles = PayrollService.departmentTitles(for: payrolls)
                    Dao().archive(payrolls: payrolls)
                } else {
                    Alert(viewController: self).show(message: .error)
                }
                spinner.stopAnimating()
            }
        }
    }
}

extension RootVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootCell.reuseIdentifier, for: indexPath) as? RootCell else {
            return UITableViewCell()
        }
        cell.configure(with: departmentTitles, color: color?.base, indexPath: indexPath)
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let departmentTitle = departmentTitles[indexPath.row]
        var filteredPayrolls = payrolls.filter { $0.department_title == departmentTitle }
        filteredPayrolls.sort {
            Double($0.total_payments ?? "") ?? 0.0 > Double($1.total_payments ?? "") ?? 0.0
        }
        let jobTitleVC = JobTitleVC(payrolls: filteredPayrolls,
                                    title: departmentTitles[indexPath.row],
                                    color: color)
        navigationController?.pushViewController(jobTitleVC, animated: true)
    }
}

extension RootVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.setText(color: color?.dark.contrast ?? .white)
        searchController.searchBar.tintColor = color?.dark.contrast
        if let text = searchController.searchBar.text, !text.isEmpty {
            departmentTitles = PayrollService.departmentTitles(for: payrolls).filter {
                $0.lowercased().contains(text.lowercased())
            }
        } else {
            departmentTitles = PayrollService.departmentTitles(for: payrolls)
        }
    }
}


