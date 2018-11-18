//
//  CollectionViewCell.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/16/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell
{
    @IBOutlet var Image: UIImageView!
    
    func displayContent(image: String)
    {
        Image.downloadImage(from: image)
    }
}
