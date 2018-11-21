//
//  ViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/10/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController
{
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //do the stuff for the loogin
    @IBAction func loginFuc(_ sender: Any)
    {
                Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!)
                {
                    (user, error) in
        
                    // check if the user input the correct information
                    if let error = error
                    {
                        // print out the error so we know what went wrong
                        print(error.localizedDescription)
        
                        // tell them that something went wrong
                        // don't let them go anywhere until they get the info right
                        self.errorMessage.isHidden = false
                    }
        
                    else if let user = user
                    {
                        // print it out so we can see the user's info and know what's going on
                        print(user)
        
                        //make sure that the error message is hidden because they input the correct information
                        self.errorMessage.isHidden = true
        
                        self.performSegue(withIdentifier: "loginToFeed", sender: self)
                    }
                }
        
        
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


