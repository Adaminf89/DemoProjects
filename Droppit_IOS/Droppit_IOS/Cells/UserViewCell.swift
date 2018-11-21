//
//  UserViewCell.swift
//  
//
//  Created by Adam Infiesto on 12/12/17.
//

import UIKit

class UserViewCell: UITableViewCell
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    var userID: String!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
