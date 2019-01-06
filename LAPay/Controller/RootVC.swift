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
    private var isFiltering = false
    private var departmentTitles = [String]()
    private var filteredDepartmentTitles = [String]() {
        didSet {
            if isFiltering {
                departmentTitles = filteredDepartmentTitles
            } else {
                departmentTitles = PayrollService.departmentTitles(for: payrolls)
            }
            tableView.reloadData()
        }
    }
    private var color: Color? {
        didSet {
            tableView.reloadData()
        }
    }
    var payrolls = [Payroll]() {
        didSet {
            departmentTitles = PayrollService.departmentTitles(for: payrolls)
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
        configureNavigationController()
        configureThemeButton()
        view.backgroundColor = color!.dark
        self.setStatusBarStyle(UIStatusBarStyleContrast)
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func configureThemeButton() {
        let themButton = UIBarButtonItem(title: "Theme", style: .done, target: self, action: #selector(themeButtonTapped))
        navigationItem.rightBarButtonItem = themButton
    }
    
    @objc private func themeButtonTapped() {
        let themeVC = ThemeVC(delegate: self)
        navigationController?.pushViewController(themeVC, animated: true)
    }
    
    private func loadColor() {
        color = Dao().unarchiveColor() ?? Color(title: "Mint", base: .flatMint, dark: .flatMintDark)
    }
    
    func choose(color: Color) {
        self.color = color
        Dao().archive(color: color)
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = color?.dark
        let textAttributes = [NSAttributedString.Key.foregroundColor: color?.contrast ?? .white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = color?.contrast
        navigationController?.setStatusBarStyle(UIStatusBarStyleContrast)
        navigationController?.hidesNavigationBarHairline = true
    }
    
    private func fetchPayrolls() {
        payrolls = Dao().unarchivePayrolls() ?? [Payroll]()
        if payrolls.isEmpty {
            refresh()
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootCell.reuseIdentifier, for: indexPath) as? RootCell,
        let color = color else {
            return UITableViewCell()
        }
        cell.configure(with: departmentTitles, color: color.base, indexPath: indexPath)
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var filteredPayrolls = payrolls.filter { $0.department_title == departmentTitles[indexPath.row] }
        filteredPayrolls.sort { Double($0.total_payments!)! > Double($1.total_payments!)! }
        let jobTitleVC = JobTitleVC(payrolls: filteredPayrolls)
        jobTitleVC.title = departmentTitles[indexPath.row]
        jobTitleVC.color = color?.base
        navigationController?.pushViewController(jobTitleVC, animated: true)
    }
}

extension RootVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.tintColor = color?.contrast
        searchController.searchBar.setSerchTextcolor(color: color?.contrast ?? .white)
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            filteredDepartmentTitles = PayrollService.departmentTitles(for: payrolls).filter {
                $0.lowercased().contains(text.lowercased())
            }
        } else {
            isFiltering = false
            filteredDepartmentTitles = [String]()
            view.endEditing(true)
        }
    }
}

extension UISearchBar {
    public func setSerchTextcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}

