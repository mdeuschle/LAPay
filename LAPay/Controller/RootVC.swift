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
    private var color: Color? {
        didSet {
            tableView.reloadData()
        }
    }
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
        loadColor()
        self.setStatusBarStyle(UIStatusBarStyleContrast)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        configureNavigationController()
        configureThemeButton()
        view.backgroundColor = color!.dark
    }
    
    func configureThemeButton() {
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
        let contrastColor = ContrastColorOf(color!.dark, returnFlat: true)
        let textAttributes = [NSAttributedString.Key.foregroundColor: contrastColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = contrastColor
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
    
    @objc private func refresh() {
        let spinner = UIActivityIndicatorView(style: .gray)
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

