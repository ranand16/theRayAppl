//
//  AttendanceObject.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 25/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import Foundation
import Parse

class AttendanceObject{
    var todayAttendance = [Bool]()
    var attendanceObjs = [PFObject]()
    var studentNames = [String]()
    var studentCount = Int()
}
