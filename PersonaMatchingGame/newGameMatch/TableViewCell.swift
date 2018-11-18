//
//  TableViewCell.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/15/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var daName: UILabel!
    @IBOutlet weak var daTime: UILabel!
    @IBOutlet weak var daTurns: UILabel!
    @IBOutlet weak var daDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
