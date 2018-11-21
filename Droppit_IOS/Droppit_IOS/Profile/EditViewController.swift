//
//  EditViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/16/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var DisplayImage: UIImageView!
   
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            }
            else
            {
                // Error unable to upload profile image
            }
        }
    }
    
    func saveToDatabaseWithUrl(imageUrl: String)
    {
        guard (DisplayImage) != nil else { return }
        guard let caption = captionTextField.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //node
        let databaseUserAcctRef = Database.database().reference().child("user_acct_settings/\(uid)")
        
        //node values
        let objAct = [
            "description" : caption,
            "profile_photo" : imageUrl
        ]

        databaseUserAcctRef.updateChildValues(objAct)
        
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("photos/users/\(uid)/profile_photo")
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
    
    // This function allow the selected target from either photo liabary or the camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        
        DisplayImage.image = info[.editedImage] as? UIImage;
        dismiss(animated: true, completion: nil)
    }
    
    // hide keyboard when tap outside of the keyboard (Dis da wei!)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for item in self.view.subviews {
            if item.isKind(of: UITextField.self) && item.isFirstResponder {
                item.resignFirstResponder()
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
