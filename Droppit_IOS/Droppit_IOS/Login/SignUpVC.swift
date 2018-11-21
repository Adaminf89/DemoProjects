//
//  SignUpVC.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/16/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPW: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func handleSignUp()
    {
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        guard let confirmpass = confirmPW.text else {return}
        guard let image = profileImageView.image else {return}
    
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: username, email: email,profileImageURL: url!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                            }
                        }
                    } else {
                        // Error unable to upload profile image
                    }
                    
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
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
        
                    completion(url)
                    // success!
                }
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    func saveProfile(username:String, email: String,profileImageURL:URL,completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/\(uid)")
        
        let userObject = [
            "email":email,
            "user_id": uid,
            "username": username
            ] as [String:Any]
        
        let databaseUserAcctRef = Database.database().reference().child("user_acct_settings/\(uid)")
        
        let objAct = [
            "description" : "Add to your profile",
            "display_name" : username,
            "profile_photo" : profileImageURL.absoluteString,
            "user_id": uid,
            "username": username
        ]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
        databaseUserAcctRef.setValue(objAct){ error, ref in
            completion(error == nil)
        }
    }
    
    
    
    @IBAction func selectPic(_ sender: Any)
    {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
    
    }
    
    // This function allow the selected target from either photo liabary or the camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        
        profileImageView.image = info[.editedImage] as? UIImage;
        dismiss(animated: true, completion: nil)
    }
    
 
    @IBAction func createAcct(_ sender: Any)
    {
        
        let imageData = profileImageView.image
        uploadProfileImage(imageData!) { url in
            
            if url != nil
            {
                print("worked")
            }
            else
            {
                // Error unable to upload profile image
                print("error")
            }
            
        }
           handleSignUp()
    }
    
    // hide keyboard when tap outside of the keyboard (Dis da wei!)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for item in self.view.subviews {
            if item.isKind(of: UITextField.self) && item.isFirstResponder {
                item.resignFirstResponder()
            }
        }
    }
    
    @IBAction func closeActivity(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
