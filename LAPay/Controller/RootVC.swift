//
//  RootVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var payrolls = [Payroll]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        WebService.shared.dataSource(with: .departmentTitle) { response in
            DispatchQueue.main.async {
                switch response {
                case let .success(data):
                    if let json = try? JSONDecoder().decode([Payroll].self, from: data) {
                        self.payrolls = json
                        print("JSON: \(json)")
                    }
                case let .failure(error?):
                    print(error)
                default:
                    print("DEFAULT")
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RootVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payrolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let payroll = payrolls[indexPath.row]
        cell.textLabel?.text = payroll.department_title
        return cell
    }
}

extension RootVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select")
    }
}
