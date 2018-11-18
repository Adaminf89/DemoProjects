//
//  UserData.swift
//  Infiesto_Adam_CE02
//
//  Created by Adam Infiesto on 3/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import Foundation

//what is used for sending and reading data
public class UserDataManager: NSObject, NSCoding
{
    var total: String?
    var tip : String?
    var tipamount : String?
    
    //init for all vars needed
    init(total: String, tip : String, tipamount : String) {
        self.total = total
        self.tip = tip
        self.tipamount = tipamount
    }
    
    //
    public func encode(with aCoder: NSCoder)
    {
        //make the value we have as Key value pair
        aCoder.encode(total, forKey:"total")
        aCoder.encode(tip, forKey:"tip")
        aCoder.encode(tipamount, forKey:"tipamount")
    }
    //this is the Decoder for objects keys
    //keys for what i want and give the data back after decodeing
    public required convenience init?(coder aDecoder: NSCoder)
    {
        //set dummy data for when stuff goes wrong
        self.init(total: "Something", tip: "is", tipamount: "wrong")
        
        //custom key for assing the value and cast back as string OBJ
        total = aDecoder.decodeObject(forKey:"total") as? String
        tip = aDecoder.decodeObject(forKey:"tip") as? String
        tipamount = aDecoder.decodeObject(forKey:"tipamount") as? String
        
    }
    
    
}
