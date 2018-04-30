//
//  AttendanceModalViewController.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 21/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse

class AttendanceModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var studNameTable: UITableView!
    @IBOutlet weak var message: UILabel!
    let attendanceId = AttendanceIdentification()
    let attendanceObj = AttendanceObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studNameTable.isHidden = true
        self.message.isHidden = true
        print(attendanceId.attendanceClass)
        print(attendanceId.schoolName)
        self.studNameTable.register(UINib(nibName: "AttendanceModalTVCell", bundle: nil), forCellReuseIdentifier: "AttendanceModalCell")
        if(attendanceId.attendanceClass == ""){
            print("there was an error!!")
        } else{
            
            if(self.attendanceId.schoolName != ""){
                let query = PFQuery(className: "AttendanceInfo")
                query.whereKey("classId" , equalTo: self.attendanceId.attendanceClass)
                query.whereKey("schoolName" , equalTo: self.attendanceId.schoolName)
                query.findObjectsInBackground(block: { (objs, err) in
                    self.attendanceObj.studentCount = (objs?.count)!
                    if(objs?.count == nil || objs?.count == 0){
                        AttendanceClassView.Instance.noClassAssignedLabel(view: self.view, label: self.message, text: "No students in this class!!", button: nil)
                    } else{
                        self.studNameTable.isHidden = false
                        for obj in objs!{
                            self.attendanceObj.attendanceObjs.append(obj)
                            self.attendanceObj.studentNames.append(obj.value(forKey: "studName") as! String)
                        }
                        self.studNameTable.reloadData()
                    }
                })
            } else{
                
            }
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        print(attendanceObj.todayAttendance)
        var attendanceEachChildObj = [[Int]]()
        for (index,attendanceObject) in attendanceObj.attendanceObjs.enumerated(){
            print("\(attendanceObj.attendanceObjs[index].value(forKey: "studName")) [\(attendanceId.x)][\(attendanceId.y)]")
            attendanceEachChildObj = attendanceObj.attendanceObjs[index].value(forKey: "attendance") as! [[Int]];
            if(attendanceObj.todayAttendance[index] == true){
                attendanceEachChildObj[attendanceId.x][attendanceId.y] = 1;
            }else{
                attendanceEachChildObj[attendanceId.x][attendanceId.y] = 0;
            }
            (attendanceObj.attendanceObjs[index])["attendance"] = attendanceEachChildObj;
            attendanceObj.attendanceObjs[index].saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("successfully saved!!!")
                } else {
                    print("There was an error!!!!")
                }
            }
//            print("\(attendanceObj.value(forKey: "studName")) +  index \(index)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceObj.studentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studNameTable.dequeueReusableCell(withIdentifier: "AttendanceModalCell", for: indexPath) as! AttendanceModalTVCell
        cell.firstName.text = attendanceObj.studentNames[indexPath.row] // setting the name of each child in the table
        attendanceObj.todayAttendance.append(false) // making all the children present by default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = studNameTable.cellForRow(at: indexPath) as! AttendanceModalTVCell
        attendanceObj.todayAttendance[indexPath.row] = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deseletedCell = studNameTable.cellForRow(at: indexPath) as! AttendanceModalTVCell
        attendanceObj.todayAttendance[indexPath.row] = false
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.isSelected = true
//    }
}
