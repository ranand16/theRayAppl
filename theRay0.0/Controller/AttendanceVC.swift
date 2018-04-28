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
    
    let user = User()
    let attendanceIdentification = AttendanceIdentification()
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        user.classesAssigned = (currentUser?.value(forKey: "classAssigned") as! [[String]])
        user.dayCommence = (moment(currentUser?.value(forKey: "dayCommence") as! String)?.get("H"))!;
        user.dayEnds = (moment(currentUser?.value(forKey: "dayEnds") as! String)?.get("H"))!;
        user.sessionCommence = currentUser?.value(forKey: "sessionCommence") as! Date
        user.isWhat = currentUser?.value(forKey: "isWhat") as! String
        let sessionCommenceMoment = moment(user.sessionCommence)
        if(user.isWhat.contains("TEACHER")){// if the user is a teacher
            if(user.classesAssigned==nil || user.classesAssigned[0][0]=="0"){
                AttendanceClassView.Instance.noClassAssignedLabel(view: self.view, label: noClassesAssigned, button: classButton, text: "You have no classes now")
            } else{
                let hr = moment(); // current time
                if(hr.hour<user.dayCommence || hr.hour>user.dayEnds){
                    AttendanceClassView.Instance.noClassAssignedLabel(view: self.view, label: noClassesAssigned, button: classButton, text: "You are only allowed to take attendance in school hours")
                } else{
                    let date = moment();
                    let diffHours = hr.hour - user.dayCommence; // say 4th hour
                    let diffDays = date.day - sessionCommenceMoment.day; // say 60 days
                    attendanceIdentification.x = diffDays/7 ; // 60/7 = 8 - 1 = 7
                    attendanceIdentification.y = ((diffDays%7)*8) + diffHours; // 4*8 + 4 = 35
                    print(user.classesAssigned)
//                    moment().format('dddd');
                    let weekDay = moment().weekdayName
                    let weeKDayNum = moment().weekday
                    if(diffHours>4){// this checking is done because lunch break comes after 4th hour
                        attendanceIdentification.attendanceClass = user.classesAssigned[weeKDayNum-1][diffHours+1]
                        classButton.setTitle(attendanceIdentification.attendanceClass, for: .normal)
                    } else {
                        attendanceIdentification.attendanceClass = user.classesAssigned[weeKDayNum-1][diffHours]
                        classButton.setTitle(attendanceIdentification.attendanceClass, for: .normal)
                    }
                }
            }
        } else{ // if the user is not a teacher
            AttendanceClassView.Instance.noClassAssignedLabel(view: self.view, label: noClassesAssigned, button: classButton, text: "You dont have permission to take attendance")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="toAttendancesModal"){
            let destVC = segue.destination as! AttendanceModalViewController
            destVC.attendanceId.attendanceClass = attendanceIdentification.attendanceClass
            destVC.attendanceId.x = attendanceIdentification.x
            destVC.attendanceId.y = attendanceIdentification.y
        }
    }
    
    @IBAction func classPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAttendancesModal", sender: self)
    }
}
