//
//  AddViewController.swift
//  PlanningApp
//
//  Created by Meena Sambandam on 7/16/20.
//  Copyright © 2020 Smriti Somasundaram. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    

    
    public var completion: ((String, String, Date)-> Void)?
    override func viewDidLoad() {
    super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
    }
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty{
            let targetDate = datePicker.date
        completion?(titleText, bodyText, targetDate)
            //adding data to firebase database
            let user = Auth.auth().currentUser
            let uid = user!.uid
            let ref = Database.database().reference()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, YYYY"
            let dateForm = formatter.string(from: datePicker.date)
            let newUserReference = ref.child("Accounts").child(uid).child("Reminders").child(dateForm).child(titleField.text!)
            newUserReference.setValue(["title": titleField.text!, "body": bodyField.text!, "date": dateForm])

            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
