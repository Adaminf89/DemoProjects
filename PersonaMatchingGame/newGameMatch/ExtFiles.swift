//
//  ExtFiles.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/9/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import Foundation

extension MutableCollection
{
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle()
    {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in indices.dropLast()
        {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: numericCast(arc4random_uniform(numericCast(diff))))
            swapAt(i, j)
        }
    }

    
    
   
}
