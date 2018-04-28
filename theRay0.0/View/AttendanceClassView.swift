//
//  AttendanceClassView.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 28/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class AttendanceClassView{
    private static var _instance = AttendanceClassView()
    
    static var Instance: AttendanceClassView{
        return _instance
    }
    
    func noClassAssignedLabel(view: UIView, label: UILabel, button: UIButton, text: String){
        label.text = text
        label.isHidden = false // show the messageLabel
        label.numberOfLines = 4
        label.sizeToFit()
        label.center = view.center
        button.isHidden = true
    }
}
