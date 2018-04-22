//
//  AttendanceVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 12/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse
import SwiftMoment

class AttendanceVC: UIViewController {
    
    @IBOutlet weak var noClassesAssigned: UILabel!
    @IBOutlet weak var classButton: UIButton!
    var x = Int()
    var y = Int()
    var attendaceClass = String()
    var classes = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        if((currentUser?.value(forKey: "isWhat") as! String).contains("TEACHER")){
            if(currentUser?.value(forKeyPath: "classAssigned")==nil){
                noClassesAssigned.text = "You have no classes now"
                noClassesAssigned.isHidden = false // show the messageLabel
                noClassesAssigned.numberOfLines = 4
                noClassesAssigned.sizeToFit()
                noClassesAssigned.center = self.view.center
                classButton.isHidden = true
            } else{
                let hr = moment();
                if(hr.hour<15 || hr.hour>23){
                    noClassesAssigned.isHidden = false // show the messageLabel
                    noClassesAssigned.text = "You are only allowed to take attendance in school hours"
                    noClassesAssigned.numberOfLines = 4
                    noClassesAssigned.sizeToFit()
                    noClassesAssigned.center = self.view.center
                    classButton.isHidden = true
                } else{
                    let dayCommence = moment(currentUser?.value(forKey: "dayCommence") as! String)?.get("H");
                    let sessionCommence = moment(currentUser?.value(forKey: "sessionCommence") as! Date)
                    let date = moment();
                    let diffHours = hr.hour - dayCommence!; // say 4th hour
                    let diffDays = date.day - sessionCommence.day; // say 60 days
                    
                    x = diffDays/7 ; // 60/7 = 8 - 1 = 7
                    y = ((diffDays%7)*8) + diffHours; // 4*8 + 4 = 35
                    
                    classes = currentUser?.value(forKey: "classAssigned") as! [[String]];
                    print(classes)
                    
//                    moment().format('dddd');
                    let weekDay = moment().weekdayName
                    let weeKDayNum = moment().weekday
                    attendaceClass = classes[weeKDayNum-1][diffHours]
                    classButton.setTitle(attendaceClass, for: .normal)
                }
            }
        } else{
            print(currentUser?.value(forKey: "isWhat") as! String)
            noClassesAssigned.isHidden = false // show the messageLabel
            noClassesAssigned.text = "You dont have permission to take attendance"
            noClassesAssigned.numberOfLines = 4
            noClassesAssigned.sizeToFit()
            noClassesAssigned.center = self.view.center
            classButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="toAttendancesModal"){
            let destVC = segue.destination as! AttendanceModalViewController
            destVC.classForAttendance = self.attendaceClass
            destVC.x = self.x
            destVC.y = self.y
        }
    }
    
    @IBAction func classPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAttendancesModal", sender: self)
    }
}
