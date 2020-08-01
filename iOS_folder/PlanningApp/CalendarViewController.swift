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
    //@IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        let currentDate = formatter.string(from: date)
        print(currentDate)
    
    }
}
