//
//  UserProfileViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
   
    
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var text_vjew: UITextView!
    @IBOutlet var collectionView: UICollectionView!
    
    var photos = [UserAccountSetting]()
    var userPhoto = [Photo]()
    let userID = Auth.auth().currentUser?.uid
    let ref = Database.database().reference().child("user_acct_settings")


    override func viewDidLoad()
    {
        super.viewDidLoad()
        guard let uid = Auth.auth().currentUser?.uid else { return }
       
        
        ref.observe(DataEventType.value, with: {DataSnapshot in
            
            if DataSnapshot.childrenCount > 0
            {
                self.ref.removeAllObservers()
                
                for p in DataSnapshot.children.allObjects as! [DataSnapshot]
                {
                    let photoObj = p.value as? [String : AnyObject]
                    let desc = photoObj?["description"]
                    let display_name = photoObj?["display_name"]
                    let profile_photo = photoObj?["profile_photo"]
                    let uuid = photoObj?["user_id"]
                    let username = photoObj?["username"]
                    
                    let data = UserAccountSetting(desc: desc as! String, display_name: display_name as! String, profile_photo: profile_photo as! String, user_id: uuid as! String, username: username as! String)
                    
                    if (data.user_id == uid)
                    {
                        self.photos.append(data)
                    }
                    
                }
                
                let ref2 = Database.database().reference().child("user_photos").child(uid)
                
                ref2.observe(DataEventType.value, with: {DataSnapshot in
                    
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
                            
                           
                            self.userPhoto.append(data)
                        
                        }
                    }
                    
                })
                self.collectionView.reloadData()
                self.image_view.downloadImage(from: self.photos[0].profile_photo)
                self.text_vjew.text = self.photos[0].desc
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return userPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        //let photo = photos[indexPath.row]
        
        let model : Photo
        
        model = userPhoto[indexPath.row]
    
        cell.displayContent(image: model.image_path)
        
        return cell
    }
    
}


