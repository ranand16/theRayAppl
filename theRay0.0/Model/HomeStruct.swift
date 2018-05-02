//
//  HomeStruct.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 09/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

struct homeCellStruct{
    public var homeCellText : [String: [String]] = [
    "PRINCIPAL": ["Class","Manage Fees","Student","Subject","Staff","User List","Homework","Exam","Communicate","Transport","Gallery","Time Table","Library","Review Log","Online Test","Help"],
    "ADMIN": ["Class","Manage Fees","Student","Subject","Staff","User List","Homework","Exam","Communicate","Transport","Gallery","Time Table","Library","Review Log","Online Test","Help"],
    "TEACHER": ["Class","Student","Subject","Homework","Exam","Communicate","Gallery","Time Table","Online Test","Help"],
    "OTHERS":["Class","Manage Fees","Student","Subject","Staff","User List","Homework","Exam","Communicate","Transport","Gallery","Time Table","Library","Review Log","Online Test","Help"]
    ]

//    public var homeCellText : [String] = ["Class","Manage Fees","Student","Subject","Staff","User List","Homework","Exam","Communicate","Transport","Gallery","Time Table","Library","Review Log","Online Test","Help"]
    
    public var homeCellImages = [#imageLiteral(resourceName: "stack"),#imageLiteral(resourceName: "fees"),#imageLiteral(resourceName: "student"),#imageLiteral(resourceName: "student"),#imageLiteral(resourceName: "teacher"),#imageLiteral(resourceName: "users"),#imageLiteral(resourceName: "homework"),#imageLiteral(resourceName: "help-1"),#imageLiteral(resourceName: "messenger"),#imageLiteral(resourceName: "transport"),#imageLiteral(resourceName: "student"),#imageLiteral(resourceName: "student"),#imageLiteral(resourceName: "librarian"),#imageLiteral(resourceName: "review"),#imageLiteral(resourceName: "student"),#imageLiteral(resourceName: "help")]
}
