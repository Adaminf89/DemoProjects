//
//  ViewController.swift
//  Yips
//
//  Created by Adam Infiesto on 3/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//  Icon rights reservered to Kubernetes Operational Burdens

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var labeltest: UILabel!
    //get a session
    @IBOutlet weak var txtField: UITextField!
    let seesion = WCSession.default
    var da_total: Double = 0.0
    var da_tip : Int = Int(0.0)
    var da_tipAmount : Double = 0.0
    var daString = ""
    var daUserTrakerData = ""
    var tupValue : (Int, Double, Double)!
    let defaults = UserDefaults.standard
    var arrayData : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        //get infomation and pass it
        self.txtField.keyboardType = UIKeyboardType.decimalPad
        navigationItem.title = "Yipz"
        NotificationCenter.default.addObserver(self, selector: #selector(messageRe(info:)), name: NSNotification.Name(rawValue: "pushdata"), object: nil)
        if arrayData.count == 0
        {
            arrayData = defaults.stringArray(forKey: "arrayData") ?? [String]()
        }
        //close keyboard
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //recieving the data form watch
    @objc func messageRe(info: NSNotification)
    {
        let message = info.userInfo!
        
        //cant update uielements on main thread
        DispatchQueue.main.async
            {
                self.daString = (message["data"] as? String)!
                //self.labeltest.text = self.daString
                self.arrayData.append(self.daString)
                self.defaults.set(self.arrayData, forKey: "arrayData")
        }
         
    }
    
    @IBAction func saveMonth(_ sender: Any)
    {
        daUserTrakerData = txtField.text!
        print(daUserTrakerData)
        defaults.set(daUserTrakerData, forKey: "UserTraker")

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toTable"
        {
            let tVC = segue.destination as! TableViewCon
            tVC.arraydata = arrayData
        }
        else
        {
            let tVC = segue.destination as! TrackerController
            tVC.arraydata = arrayData
        }
    }
  
    //sending your data to watchtest
    func sendData()
    {
        if self.seesion.isPaired == true && self.seesion.isWatchAppInstalled
        {
            self.seesion.sendMessage(["data": "your text value"], replyHandler: nil, errorHandler: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
}

