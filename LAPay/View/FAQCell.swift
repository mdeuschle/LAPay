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
        titleLabel.numberOfLines = 0
        detailLabel.numberOfLines = 0
        selectionStyle = .none
    }
    
    func configure(with faq: FAQ, color: Color?) {
        let color = color?.base ?? .black
        titleLabel.text = faq.question
        detailLabel.text = faq.answer
        titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
        detailLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
        backgroundColor = color
    }
}
