//
//  TableViewController.swift
//  Yips WatchKit Extension
//
//  Created by Adam Infiesto on 3/16/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class TableViewController : WKInterfaceController, WCSessionDelegate
{
    
    let watchSession: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    @IBOutlet var tableView: WKInterfaceTable!
    var UserData = UserDataObjects().objectArray
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        // Configure interface objects here.
        //userCount = daclass.objectArray.count
        
//       let daContext = context
////
//        UserData = daContext as! [UserDataManager]
//        
        setup()
        
        watchSession?.delegate = self
        watchSession?.activate()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    }
    
  
    
    func setup()
    {
       //loadData()
    
       tableView.setNumberOfRows(UserData.count, withRowType: "TAG_04")

        for i in 0..<(UserData.count)
        {
            let table = tableView.rowController(at: i) as? ImageCell

            table?.txtLbl.setText("Your Total: "+UserData[i].total!+" Your Tip: "+UserData[i].tip!+" . ")

        }

//        tableView.setNumberOfRows(UserDataObjects.init().objectArray.count, withRowType: "TAG_04")
//
//        for i in 0..<(UserDataObjects.init().objectArray.count)
//        {
//            let table = tableView.rowController(at: i) as? ImageCell
//
//            //table?.imageView.setImage(UserDataObjects().objectArray[i].image)
//            table?.imageView.setImageNamed(UserDataObjects().objectArray[i].total)
//
//        }
//
    }
    
}
