//
//  ViewController.swift
//  daily_planner_app
//
//  Created by Alexis Wu on 7/18/20.
//  Copyright © 2020 Alexis Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(red: 147/255, green: 168/255, blue: 178/255, alpha: 1)
        
        loginButton.backgroundColor = UIColor.init(red: 0/255, green: 35/255, blue: 174/255, alpha: 1)
        loginButton.layer.cornerRadius = 15.0
        loginButton.tintColor = UIColor.white
        
    }


}

