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

class CalendarViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        calendar.delegate = self
        
        // calendar.flow = .Vertical
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let user = Auth.auth().currentUser
        let uid = user!.uid
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        let currentDate = formatter.string(from: date)
        print(currentDate)
        
        let ref = Database.database().reference().child("Accounts").child(uid).child("Reminders")
        ref.child(currentDate).observe(.value, with: { snapshot in
             var newItems: [MyReminder] = []
             for child in snapshot.children {
               if let snapshotChild = child as? DataSnapshot,
                let reminderItem = MyReminder(snapshot: snapshotChild) {
                 newItems.append(reminderItem)
               }
             }
        //self.items = newItems
        self.calendarTasks.reloadData()
    })
    }
}
