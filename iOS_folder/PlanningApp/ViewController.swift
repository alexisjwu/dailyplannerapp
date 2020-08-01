//
//  ViewController.swift
//  PlanningApp
//
//  Created by Meena Sambandam on 7/9/20.
//  Copyright © 2020 Smriti Somasundaram. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseDatabase
class ViewController: UIViewController {
   
    var items: [MyReminder] = []

    @IBOutlet var table: UITableView!
    var models = [MyReminder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                print("Completion Notifications")
            }
            else if error != nil {
                print("error occurred")
            }
        })
        let user = Auth.auth().currentUser
        let uid = user!.uid
        //getting current date
        let currentDay = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let result = formatter.string(from: currentDay)
         print(result)
        //showing data values on list
       let ref = Database.database().reference().child("Accounts").child(uid).child("Reminders")
        ref.child(result).observe(.value, with: { snapshot in
             var newItems: [MyReminder] = []
             for child in snapshot.children {
               if let snapshotChild = child as? DataSnapshot,
                let reminderItem = MyReminder(snapshot: snapshotChild) {
                 newItems.append(reminderItem)
               }
             }
             
             self.items = newItems
             self.table.reloadData()
           })
        
    }
    
    //logging out of the application
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    //adding a new reminder
    @IBAction func didTapAdd() {
        //show add vc
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        vc.title = "NewTitle"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
             //   let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
          //      self.models.append(new)
          //      self.table.reloadData()
                //create notification
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
    }
    navigationController?.pushViewController(vc, animated: true)
}
}
    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            // 1
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            // 2
            let listItem = items[indexPath.row]
            // 3
            var toggledCompletion = false
            // 4
            toggleCellCheckbox(cell, isCompleted: toggledCompletion)
            // 5
           toggledCompletion = true
            let seconds = 2.0
          DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            listItem.ref?.removeValue()
            }
        }
    }
    extension ViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        //deleting each item
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
              let todoItem = items[indexPath.row]
              todoItem.ref?.removeValue()
            }
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row].title
            cell.detailTextLabel?.text = items[indexPath.row].body
            return cell
        }
        func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
          if !isCompleted {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
          } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
          }
        }
}
struct MyReminder {
    let title: String
    let date: String
    let body: String
    let ref : DatabaseReference?
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let title = value["title"] as? String,
        let date = value["date"] as? String,
        let body = value["body"] as? String
     
        else {
        return nil
      }
      
      self.ref = snapshot.ref
      self.title = title
      self.date = date
      self.body = body
    }
}


