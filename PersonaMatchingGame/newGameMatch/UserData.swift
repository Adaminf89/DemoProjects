//
//  UserData.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/15/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import Foundation
class Users
{
    var ID : String
    var time : String
    var turns : String
    
    var oneLine : String
    {
        return "Name \(ID) finished in \(time) and \(turns) turns"
    }
    
    init(ID : String, time: String, turns : String) {
        self.ID = ID
        self.time = time
        self.turns = turns
    }
}
