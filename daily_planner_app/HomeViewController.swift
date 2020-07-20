//
//  HomeViewController.swift
//  daily_planner_app
//
//  Created by Alexis Wu on 7/18/20.
//  Copyright © 2020 Alexis Wu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var goToCalendarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(red: 147/255, green: 168/255, blue: 178/255, alpha: 1)
        
        goToCalendarButton.backgroundColor = UIColor.init(red: 0/255, green: 35/255, blue: 174/255, alpha: 1)
        goToCalendarButton.layer.cornerRadius = 15.0
        goToCalendarButton.tintColor = UIColor.white
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
