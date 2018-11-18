//
//  FeedTableViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/10/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewController: UITableViewController
{
    var photos = [Photo]()
    let ref = Database.database().reference().child("photos")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        ref.observe(DataEventType.value, with: {DataSnapshot in
            
            if DataSnapshot.childrenCount > 0
            {
                self.ref.removeAllObservers()
                
                for p in DataSnapshot.children.allObjects as! [DataSnapshot]
                {
                    let photoObj = p.value as? [String : AnyObject]
                    let caption = photoObj?["caption"]
                    let image_path = photoObj?["image_path"]
                    let date_created = photoObj?["date_created"] as! String
                    let location = photoObj?["location"] as! String
                    let locationlong = photoObj?["locationlong"] as! String
                    let mPrivate = photoObj?["mPrivate"] as! String
                    
                    
                    let data = Photo(caption: caption as! String, date_created: date_created , image_path: image_path as! String, location: location , locationlong: locationlong , mPrivate: mPrivate , tags: "test", user_id: "test")
                    
                    self.photos.append(data)
                }
                
                //reloaddata
                self.tableView.reloadData()
            
            }
            
        })
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! UserViewCell
        
        let model : Photo
        
        model = photos[indexPath.row]
        cell.userName.text = model.caption
        cell.userImage.downloadImage(from: self.photos[indexPath.row].image_path)

        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /* show detail about each post */
        if let indexPath = tableView.indexPathForSelectedRow
        {
            let selectedRow = indexPath.row
            let detailVC = segue.destination as! DetailViewController
            detailVC.photos = self.photos[selectedRow]
        }
        
    }
    
    
}

extension UIImageView
{
    
    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        
        task.resume()
    }
}
