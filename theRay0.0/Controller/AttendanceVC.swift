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
    var x = Int()
    var y = Int()
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
            } else{
                
                let hr = moment();
                
                if(hr.hour<7 || hr.hour>15){
                    noClassesAssigned.isHidden = false // show the messageLabel
                    noClassesAssigned.text = "You are only allowed to take attendance in school hours"
                    noClassesAssigned.numberOfLines = 4
                    noClassesAssigned.sizeToFit()
                    noClassesAssigned.center = self.view.center
                } else{
                    let dayCommence = moment(currentUser?.value(forKey: "dayCommence") as! String)?.get("H");
                    let sessionCommence = moment(currentUser?.value(forKey: "sessionCommence") as! Date)
                    let date = moment();
                    let diffHours = hr.hour - dayCommence!; // say 4th hour
                    let diffDays = date.day - sessionCommence.day; // say 60 days
                    
                    x = diffDays/7 ; // 60/7 = 8 - 1 = 7
                    y = ((diffDays%7)*8) + diffHours; // 4*8 + 4 = 35
                    
                    classes = currentUser?.value(forKey: "classAssigned") as! [[String]];
                }
            }
        } else{
            print(currentUser?.value(forKey: "isWhat") as! String)
            noClassesAssigned.isHidden = false // show the messageLabel
            noClassesAssigned.text = "You dont have permission to take attendance"
            noClassesAssigned.numberOfLines = 4
            noClassesAssigned.sizeToFit()
            noClassesAssigned.center = self.view.center
        }
    }
}
