//
//  loginView.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 27/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class loginView{
    func singInOrSignUP(button1: UIButton, button2: UIButton, mode: Bool) -> Void{ // for manipulate signInOrSignUp button
        if(mode == true){
            button1.setTitle("Sign In", for: .normal)
            button2.setTitle("Sign Up", for: .normal)
        } else{
            button1.setTitle("Sign Up", for: .normal)
            button2.setTitle("Sign In", for: .normal)
        }
    }
    
    func signUpAsText(label: UILabel, identityFromSegue: String, mode: Bool)->UILabel{
        if mode==true{
            label.text = ""
        } else{
            label.text = "Sign Up as \(identityFromSegue)"
        }
        return label
    }
}
