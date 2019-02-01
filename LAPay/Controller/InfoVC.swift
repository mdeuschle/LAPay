//
//  InfoVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/31/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

class InfoVC: UITableViewController {
    
    let faqs = FAQService.shared.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("\(#function) has not been implemented")
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "FAQCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FAQCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell",
                                                       for: indexPath) as? FAQCell else {
                                                        return UITableViewCell()
        }
        let faq = faqs[indexPath.row]
        cell.configure(with: faq)
        return cell
    }
}
