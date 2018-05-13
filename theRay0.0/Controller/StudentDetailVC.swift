//
//  StudentDetailVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 13/05/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class StudentDetailVC: UIViewController {
    
    @IBOutlet weak var studClass: UILabel!
    @IBOutlet weak var studName: UILabel!
    @IBOutlet weak var studIMage: UIImageView!
    var searchStudentDetails = Student()
    override func viewDidLoad() {
        super.viewDidLoad()
        studName.text = searchStudentDetails.studentName
        studClass.text = searchStudentDetails.classId
        studIMage.image = #imageLiteral(resourceName: "student")
    }
}
