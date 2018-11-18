//
//  DetailWatchController.swift
//  Infiesto_Adam_CE02 WatchKit Extension
//
//  Created by Adam Infiesto on 3/13/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class DetailWatchController: WKInterfaceController, WCSessionDelegate
{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    let watchSession: WCSession? = WCSession.isSupported() ? WCSession.default : nil

    @IBOutlet var textlbl: WKInterfaceLabel!
    var da_total: Double = 0.0
    var da_tip : Int = Int(0.0)
    var da_tipAmount : Double = 0.0
    var daString = ""
    var arraydata = UserDataObjects()
    let seesion = WCSession.default
    var temp : Double = 0.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        watchSession?.delegate = self
        watchSession?.activate()
        
        //set this context from the last controller
        let daContext = context as? (Int, Double, Double)
        //TODO: tip amount is -2 dollors?
        da_tip = (daContext?.0)!
        da_tipAmount = (daContext?.2)!
        da_total = daContext!.1
        
        temp = da_total + da_tipAmount
        
        daString = String(temp)
        
        print(da_tip)
        
        
        textlbl.setText("Your Total "+daString+".")
        print("lol")
    
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
//    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
//
//        let segueContext = userstuff
//
//        return segueContext
//
//    }
   
    
    @IBAction func logData()
    {
        //send data through the session notfCenter
        self.seesion.sendMessage(["data": temp.description], replyHandler: nil, errorHandler: nil)
        
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
