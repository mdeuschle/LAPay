//
//  FAQCell.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/15/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configure(with faq: FAQ) {
        titleLabel.text = faq.question
        detailLabel.text = faq.answer
    }
}
