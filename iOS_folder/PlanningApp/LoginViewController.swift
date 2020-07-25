//
//  LoginViewController.swift
//  PlanningApp
//
//  Created by Meena Sambandam on 7/25/20.
//  Copyright © 2020 Smriti Somasundaram. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorText: UILabel!
    
    override func viewDidLoad() {
        errorText.isHidden = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginCheck(_ sender: Any) {
        errorText.isHidden = true
                guard let emailText = email.text else {
                    return
                }
                guard let passwordText = password.text else { return }
                Auth.auth().signIn(withEmail: emailText, password: passwordText) { user, error in
                    if error == nil && user != nil {
                        let uid = Auth.auth().currentUser?.uid
                        self.performSegue(withIdentifier: "goMainSegue", sender: self)
                    } else {
                        self.errorText.isHidden = false
                    }
                }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

}
