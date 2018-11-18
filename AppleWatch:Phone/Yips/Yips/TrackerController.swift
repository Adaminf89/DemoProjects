//
//  TrackerController.swift
//  Yips
//
//  Created by Adam Infiesto on 3/23/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//  Icon rights reservered to Kubernetes Operational Burdens.

import WatchKit

class TrackerController: UIViewController
{
    var arraydata: [String] = []
    var userSetGoals = ""
    var sum = 0.0
    var adverage = 0.0
    
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var userGoals: UILabel!
    @IBOutlet weak var totalAdv: UILabel!
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        //get infomation and pass it
        navigationItem.title = "Tracker"
        userSetGoals = defaults.string(forKey: "UserTraker")!
        
        let doubleArray = arraydata.compactMap
        {
            Double($0)
        }
        
        //set the sum from the array
        sum = doubleArray.reduce(0, +)
        adverage = doubleArray.reduce(0.0)
        {
            return $0 + $1/Double(doubleArray.count)
        }
        
        //update ui fields
        totalValue.text = "You've spent $"+sum.description+" thus far..."
        totalAdv.text = "Your adverage spending is $"+adverage.description+" ."
        userGoals.text = userSetGoals.description
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
