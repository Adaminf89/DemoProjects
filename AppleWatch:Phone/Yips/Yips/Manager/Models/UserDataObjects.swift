//
//  Content.swift
//  Infiesto_Adam_CE02
//
//  Created by Adam Infiesto on 3/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import Foundation

public class UserDataObjects : NSObject
{
    //array of object data
    var objectArray : [UserDataManager] = []
   //var tup : (String, String, String)? = nil
    
//    func addTask(task: UserDataManager)
//    {
//      self.objectArray.append(task)
//    }
//
//    func saveData(todo: UserDataManager)
//    {
//        UserDefaults.standard.set(todo , forKey: "data")
//    }
//
//    func loadData() -> UserDataManager?
//    {
//        let daclass = UserDefaults.standard.object(forKey: "data") as! UserDataManager
//        return daclass
//    }
    
    init(objectArray : [UserDataManager] = [])
    {
        self.objectArray = objectArray

    }
    
}
