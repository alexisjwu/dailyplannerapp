//
//  SignUpViewController.swift
//  PlanningApp
//
//  Created by Alexis Wu on 7/27/20.
//  Copyright © 2020 Smriti Somasundaram. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var empty: UILabel!
    @IBOutlet weak var diffPass: UILabel!
    @IBOutlet weak var invalid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empty.isHidden = true
        diffPass.isHidden = true
        invalid.isHidden = true

    }
    
    @IBAction func checkAccount(_ sender: Any) {
        empty.isHidden = true
        diffPass.isHidden = true
        invalid.isHidden = true
        
        if emailText.text?.isEmpty == true || firstName.text?.isEmpty == true || lastName.text?.isEmpty == true || password.text?.isEmpty == true || confirmpassword.text?.isEmpty == true {
            empty.isHidden = false
        }
        if empty.isHidden == true {
        let email = isValidEmail(emailText.text!)
        if (email == false) {
            invalid.isHidden = false
        }
        if (password.text != confirmpassword.text) {
            diffPass.isHidden = false
        }
        }
        //adding the coach info into database
               if empty.isHidden == true, diffPass.isHidden == true, invalid.isHidden == true {
                   Auth.auth().createUser(withEmail: emailText.text!, password: password.text!) { authResult, error in
                       guard let user = authResult?.user, error == nil else {
                           print(error!.localizedDescription)
                           return
                       }
                       let ref = Database.database().reference()
                       //   let coachesReference = ref.child("coaches")
                       let uid = user.uid
                    let newUserReference = ref.child("Accounts").child(uid).child("info")
                       newUserReference.setValue(["firstName": self.firstName.text!, "lastName": self.lastName.text!, "email":self.emailText.text!, "password": self.password.text!])
                   }
                performSegue(withIdentifier: "goHome", sender: self)
           }

    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
