//
//  DetailWatchController2.swift
//  Yips
//
//  Created by Adam Infiesto on 3/15/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class DetailWatchController2: WKInterfaceController, WCSessionDelegate
{
 
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    let watchSession: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    @IBOutlet var fName: WKInterfaceLabel!
    @IBOutlet var lName: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.fName.setText("Loading....")
        self.lName.setText("Loading....")
        
        watchSession?.delegate = self
        watchSession?.activate()
        
        // Configure interface objects here.
        let daContext = context as? [String: Int]
        let daRow = daContext!["rowIndex"]
        
        if let session = watchSession, session.isReachable
        {
            session.sendMessage(["getData": daRow!], replyHandler: { (data) in
                
                //NSKeyedArchiver.setClassName("UserDataManager", for: UserDataManager.self)
                
                NSKeyedUnarchiver.setClass(UserDataManager.self, forClassName: "UserDataManager")
                
                if let daData = data["userData"] as? Data,
                    let userData = NSKeyedUnarchiver.unarchiveObject(with: daData) as? UserDataManager
                {
                    self.fName.setText(userData.total)
                    
                    
                }
                
            },
                                errorHandler: { (error) in
                                    print(error)
            })
            
        }
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}

