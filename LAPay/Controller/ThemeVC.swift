//
//  ThemeVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/27/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

protocol ThemeDelegate: AnyObject {
    func choose(color: Color)
}

import UIKit
import ChameleonFramework

class ThemeVC: UITableViewController {
    
    weak var delegate: ThemeDelegate?
    let colors = ColorService.shared.all

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 76
        tableView.backgroundColor = .flatBlack
        tableView.register(UINib(nibName: "ThemeCell", bundle: nil), forCellReuseIdentifier: "ThemeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Choose Theme"
    }
    
    init(delegate: ThemeDelegate) {
        super.init(style: .plain)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as? ThemeCell else {
            return UITableViewCell()
        }
        let color = colors[indexPath.row]
        cell.configure(with: color)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        delegate?.choose(color: color)
        navigationController?.popViewController(animated: true)
    }
}
