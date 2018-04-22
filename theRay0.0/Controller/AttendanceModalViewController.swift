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
    var classForAttendance = String()
    var studCount = Int() // number of students in this particular class
    var studNames = [String]() // have all the student names in this array
    
    var x = Int()
    var y = Int()
    var todayAttendance = [Bool]() // to store one day attendance for this class
    var attendanceObjs = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studNameTable.isHidden = true
        self.message.isHidden = true
        print(classForAttendance)
        self.studNameTable.register(UINib(nibName: "AttendanceModalTVCell", bundle: nil), forCellReuseIdentifier: "AttendanceModalCell")
        if(classForAttendance == ""){
            print("there was an error!!")
        } else{
            let query = PFQuery(className: "AttendanceInfo")
            query.whereKey("classId" , equalTo: self.classForAttendance)
            query.findObjectsInBackground(block: { (objs, err) in
            
            self.studCount = (objs?.count)!
                if(objs?.count == nil || objs?.count == 0){
                    self.message.text = "No students in this class!!"
                    self.message.isHidden = false // show the messageLabel
                    self.message.numberOfLines = 3
                    self.message.sizeToFit()
                    self.message.center = self.view.center

                } else{
                    
                    self.studNameTable.isHidden = false
                    for obj in objs!{
                        self.attendanceObjs.append(obj)
                        self.studNames.append(obj.value(forKey: "studName") as! String)
                    }
                    self.studNameTable.reloadData()
                    
                }
            })
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        print(todayAttendance)
        var attendanceEachChildObj = [[Int]]()
        for (index,attendanceObj) in attendanceObjs.enumerated(){
            print("\(attendanceObjs[index].value(forKey: "studName")) [\(x)][\(y)]")
            attendanceEachChildObj = attendanceObjs[index].value(forKey: "attendance") as! [[Int]];
            if(todayAttendance[index] == true){
                attendanceEachChildObj[x][y] = 1;
            }else{
                attendanceEachChildObj[x][y] = 0;
            }
            (attendanceObjs[index])["attendance"] = attendanceEachChildObj;
            attendanceObjs[index].saveInBackground {
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
        return studCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studNameTable.dequeueReusableCell(withIdentifier: "AttendanceModalCell", for: indexPath) as! AttendanceModalTVCell
        cell.firstName.text = self.studNames[indexPath.row] // setting the name of each child in the table
        
        todayAttendance.append(false) // making all the children present by default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = studNameTable.cellForRow(at: indexPath) as! AttendanceModalTVCell
    
        todayAttendance[indexPath.row] = true
//        print(todayAttendance)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deseletedCell = studNameTable.cellForRow(at: indexPath) as! AttendanceModalTVCell
    
        todayAttendance[indexPath.row] = false
//        print(todayAttendance)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.isSelected = true
//    }
}
