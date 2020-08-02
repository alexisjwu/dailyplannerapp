//
//  CalendarViewController.swift
//  daily_planner_app
//
//  Created by Alexis Wu on 7/18/20.
//  Copyright © 2020 Alexis Wu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var table: UITableView!
    
    var items: [MyCalendar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        
        table.dataSource = self
        table.delegate = self
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // getting selected date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        let currentDate = formatter.string(from: date)
        print(currentDate)
        
        let user = Auth.auth().currentUser
        let uid = user!.uid
        // print(uid)
        
        
        let ref = Database.database().reference().child("Accounts").child(uid).child("Reminders")
        // print(ref.child(currentDate))
        ref.child(currentDate).observe(.value, with: { (snapshot) in
            var newItems: [MyCalendar] = []
            for child in snapshot.children {
                if let snapshotChild = child as? DataSnapshot,
                    let taskItem = MyCalendar(snapshot: snapshotChild) {
                    newItems.append(taskItem)
                }
            }
            
            self.items = newItems
            self.table.reloadData()
        })
    }
    
}

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        table.dataSource = self
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].body
        print("Getting from firebase")
        return cell
    }
}


struct MyCalendar {
    let title: String
    let date: String
    let body: String
    let ref: DatabaseReference?
    
    init?(snapshot: DataSnapshot) {
        guard
            let dict = snapshot.value as? [String: Any],
            let title = dict["title"] as? String,
            let date = dict["date"] as? String,
            let body = dict["body"] as? String
            
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.title = title
        self.date = date
        self.body = body
    }
}

