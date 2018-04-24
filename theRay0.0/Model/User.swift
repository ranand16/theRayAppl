//
//  User.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 24/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//
import Foundation

class User {
    private var _username = String()
    private var _email = String()
    private var _classAssigned = [[String]]();
    private var _sessionCommence = Date();
    private var _dayCommence = Int();
    private var _dayEnds = Int();
    private var _isWhat = String()
    private var _schoolName = String()
    private var _schoolId = String()
    
    var username: String{
        get{
            return _username
        }
        set{
            _username = newValue
        }
    }
    var email: String{
        get{
            return _email
        }
        set{
            _email = newValue
        }
    }
    var classAssigned: [[String]]{
        get{
            return _classAssigned
        }
        set{
            _classAssigned = newValue
        }
    }
    var sessionCommence : Date{
        get{
            return _sessionCommence
        }
        set{
            _sessionCommence = newValue
        }
    }
    var dayCommence : Int{
        get{
            return _dayCommence
        }
        set{
            _dayCommence = newValue
        }
    }
    var dayEnds : Int{
        get{
            return _dayEnds
        }
        set{
            _dayEnds = newValue
        }
    }
    var schoolName : String{
        get{
            return _schoolName
        }
        set{
            _schoolName = newValue
        }
    }
    var schoolId : String{
        get{
            return _schoolId
        }
        set{
            _schoolId = newValue
        }
    }
}
