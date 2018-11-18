//
//  TableViewCon.swift
//  Yips
//
//  Created by Adam Infiesto on 3/21/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//  Icon rights reservered to Kubernetes Operational Burdens

import WatchKit

class TableViewCon: UITableViewController {

    var arraydata: [String] = []
    var temp : String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.title = "Logz"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arraydata.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        
        cell.fNamelbl.text = "You Spent $"+arraydata[indexPath.row]+"."
        return cell
    }
    
}
