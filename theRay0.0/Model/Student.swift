//
//  Student.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 06/05/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import Foundation

class Student{
    private var _uid = String()
    private var _emailid = String()
    private var _classid = String()
    private var _studentname = String()
    private var _attendanceinfo = [[String]]()
    
    var uId: String{
        get{
            return _uid
        }
    }
    var emailId: String{
        get{
            return _emailid
        }
    }
    var classId: String{
        get{
            return _classid
        }
    }
    var attendanceInfo: [[String]]{
        get{
            return _attendanceinfo
        }
    }
    var studentName: String{
        get{
            return _studentname
        }
    }
    
    
}
