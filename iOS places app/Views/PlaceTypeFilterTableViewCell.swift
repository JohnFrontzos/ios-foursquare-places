//
//  PlaceTypeFilterTableViewCell.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 13/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import UIKit

class PlaceTypeFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var isVisible: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
