//
//  InterfaceController.swift
//  Yips WatchKit Extension
//
//  Created by Adam Infiesto on 3/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    

    var percentNum : Int = 15
    var totalNum : Double = 30.0
    var total : Double = 0
    var UserData : UserDataObjects!
    
    @IBOutlet var amountLbl: WKInterfaceLabel!
    @IBOutlet var tipLbl: WKInterfaceLabel!
    @IBOutlet var totalLabel: WKInterfaceLabel!
    
    @IBOutlet var amountSlider: WKInterfaceSlider!
    @IBOutlet var tipSlider: WKInterfaceSlider!
    
    let watchSession: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        amountLbl.setText("Your Amount")
        tipLbl.setText("Your Tip")
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func amountSlider(_ value: Float)
    {
        
        amountLbl.setText("Total: $" + String(value) + "0")
        
        self.totalNum = Double(value)
        
        self.total = (Double(self.percentNum) * 0.01) * Double(self.totalNum)
        
        print(self.total)
        
        DispatchQueue.main.async
            {
        
                self.totalLabel.setText(String("Tip Amount: $" + String(self.total)))
        }
        
    }
    
    @IBAction func tipSlider(_ value: Float)
    {
        self.tipLbl.setText("Percent: " + String(Int(value)) + "%")
        
        self.percentNum = Int(value)
        
        let total = (Double(self.percentNum) * 0.01) * Double(self.totalNum)
        
        print(total)
        
       totalLabel.setText(String("Tip Amount: $" + String(total)))
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        
        let segueContext = (percentNum, totalNum, total)
        return segueContext
        
    }
    
    @IBAction func saveBtn()
    {
       // UserData.objectArray.append(UserDataManager(total: totalLabel.description, tip: percentNum.description, tipamount: tipLbl.description))
    }
    

}
