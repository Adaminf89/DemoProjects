//
//  TableViewController.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/15/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    private var entityDescription : NSEntityDescription!
    private var manageContext : NSManagedObjectContext!
    var userStuff : NSManagedObject!
    let date = Date()
    let formatter = DateFormatter()
   
    var userTemp = [UserScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
          // userTemp.append(Users(ID: "test name", time: "123", turns: "84"))
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDel.persistentContainer.viewContext

        entityDescription = NSEntityDescription.entity(forEntityName: "UserScore", in: manageContext)
        
        userTemp = [NSManagedObject(entity: entityDescription, insertInto: manageContext) as! UserScore]
        
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "UserScore")
        
        do
        {

            userTemp = try manageContext.fetch(fetchRequest) as! [UserScore] 
            
            for r in userTemp
            {
                print("\(r.description)")
                
            }
            
        }
        catch let error
        {
            print("\(error).")
        }
        tableView.reloadData()
        filterList()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userTemp.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ID", for: indexPath) as! TableViewCell
        
        let userScore = userTemp[indexPath.row]
        //turns are usertaps /2
        let turns = userScore.gTaps/2
        
        //formatter for dates along with setting data vars if they exist
        
        formatter.dateFormat = "dd.MM.yyyy"
        let info = userScore.pName ?? ""
        let infoTime = userScore.gTime ?? ""
        let infoTurn = turns.description
        
        //checker
        print("\(String(describing: info))")
       
        // Configure the cell...

        cell.daName.text = "User's Name: \(info)"
        cell.daTime.text = "User's Time \(infoTime)"
        cell.daTurns.text =  "User's Turns \(infoTurn)"
        if let date = userScore.gDate as Date?
        {
            cell.daDate.text = formatter.string(from: date)
        }
        else
        {
            cell.daDate.text = ""
        }
        return cell
    }
    
    //filter for number of taps
    func filterList()
    { 
        userTemp.sort() { $0.gTaps > $1.gTaps}
        tableView.reloadData()
    }


}
