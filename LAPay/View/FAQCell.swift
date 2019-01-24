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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
