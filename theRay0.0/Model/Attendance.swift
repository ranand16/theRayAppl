//
//  Attendance.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 25/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import Foundation

class AttendanceObj{
    private var _x = Int()
    private var _y = Int()
    private var _attendaceClass = String()
    
    var x: Int{
        get{
            return _x
        }
        set{
            _x = newValue
        }
    }
    var y: Int{
        get{
            return _y
        }
        set{
            _y = newValue
        }
    }
    var attendanceClass: String{
        get{
            return _attendaceClass
        }
        set{
            _attendaceClass = newValue
        }
    }
}
