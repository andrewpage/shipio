//
//  JobTableViewCell.swift
//  Ship
//
//  Created by Andrew Page on 6/1/15.
//  Copyright (c) 2015 Ship. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
