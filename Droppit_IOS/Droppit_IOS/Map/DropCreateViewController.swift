//
//  DropCreateViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/14/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class DropCreateViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
{

    @IBOutlet weak var switchState: UILabel!
    @IBOutlet weak var DisplayImage: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var switch_public: UISwitch!
    @IBOutlet weak var captionTextField: UITextField!
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var switchValues = "true"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //returns the users location
        switchState.text = "Private"
        locManager.requestWhenInUseAuthorization()
        switch_public.addTarget(self, action: #selector(DropCreateViewController.switchIsChanged(mySwitch:)), for: UIControl.Event.valueChanged)
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways)
        {
            
            currentLocation = locManager.location
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ToCamera(_ sender: Any)
    {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func createData(_ sender: Any)
    {
        let imageData = DisplayImage.image
        uploadProfileImage(imageData!) { url in
            
            if url != nil
            {
//                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                changeRequest?.displayName = username
//                changeRequest?.photoURL = url
            }
            else {
                // Error unable to upload profile image
            }
        }
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("photos/users/\(uid)/photo\(Date().timeIntervalSince1970)")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData)
        {
            metaData, error in
            if error == nil, metaData != nil
            {
                
                storageRef.downloadURL { url, error in
                    self.saveToDatabaseWithUrl(imageUrl: url!.absoluteString)
                    completion(url)
                    self.dismiss(animated: true, completion: nil)
                    // success!
                }
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    @objc func share()
    {
        
    }
    
    @objc func switchIsChanged(mySwitch: UISwitch)
    {
        if switch_public.isOn
        {
           switchState.text = "Private"
            switchValues = "true"
        }
        else
        {
            switchState.text = "Public"
            switchValues = "False"
        }
    }
  
    
   
    
    func saveToDatabaseWithUrl(imageUrl: String)
    {
        guard (DisplayImage) != nil else { return }
        guard let caption = captionTextField.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //node
        let userPostRef = Database.database().reference().child("photos").childByAutoId()
        //get the id created
        let key = userPostRef.key
        //node
        let userRef = Database.database().reference().child("user_photos").child(uid).child(key!)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let result = formatter.string(from: date)
        
        //node values
        let values = [ "caption": caption,
                       "date_created": result,
                       "image_path": imageUrl,
                       "location": String(currentLocation.coordinate.latitude),
                       "locationlong": String(currentLocation.coordinate.longitude),
                       "mPrivate" : switchValues ,
                       "photo_id" : key!,
                       "tags": caption,
                       "user_id": uid] as [String : Any]

        userPostRef.setValue(values)
        userRef.setValue(values)
        
    }
    
    // This function allow the selected target from either photo liabary or the camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        
        DisplayImage.image = info[.editedImage] as? UIImage;
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelButtonWasPressed(_ sender: Any)
    {
        // Just dismiss the view controller since the user wants to exit the sign up process
        self.dismiss(animated: true, completion: nil)
    }
    
    // hide keyboard when tapping the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for item in self.view.subviews
        {
            if item.isKind(of: UITextField.self) && item.isFirstResponder
            {
                item.resignFirstResponder()
            }
        }
    }
}
