//
//  TableViewCell.swift
//  Infiesto_Adam_CE02
//
//  Created by Adam Infiesto on 3/13/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fNamelbl: UILabel!
    @IBOutlet weak var lNamelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
