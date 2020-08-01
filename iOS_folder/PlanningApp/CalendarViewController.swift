//
//  CalendarViewController.swift
//  daily_planner_app
//
//  Created by Alexis Wu on 7/18/20.
//  Copyright © 2020 Alexis Wu. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseDatabase
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        
        table.delegate = self
        
        let user = Auth.auth().currentUser
        let uid = user!.uid
        
        // getting chosen date
        let chosenDay = calendar.currentPage
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let result = formatter.string(from: chosenDay)
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
            
            //self.items = newItems
            self.table.reloadData()
        })
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        let currentDate = formatter.string(from: date)
        print(currentDate)
    }
    
}
