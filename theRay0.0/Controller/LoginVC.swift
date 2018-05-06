//
//  ViewController.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 01/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    override var prefersStatusBarHidden: Bool { return  true } // hides the status bar i.e; battery bar
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpAs: UILabel!
    @IBOutlet weak var signInOrUp: UIButton!
    @IBOutlet weak var signUpOrIn: UIButton!
    let loginview = loginView() // to manipulate views
    var identityFrmSegue = String() // nil when signing in and has value when signing up
    var mode = Bool()
    
    // for toggling the signUp or signIn true for SignIn false for SignUp
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mode = true
        loginview.singInOrSignUP(button1: signInOrUp, button2: signUpOrIn, mode: mode)
        loginview.signUpAsText(label: signUpAs, identityFromSegue: identityFrmSegue, mode: mode)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="signToDashboard" && identityFrmSegue != ""){
            let destVC = segue.destination as! HomeVC
            destVC.typeOfUser = identityFrmSegue
        }
    }
    
    @IBAction func signUpOrInPressed(_ sender: Any) {
        if mode==true{
            mode = false
            loginview.singInOrSignUP(button1: signInOrUp, button2: signUpOrIn, mode: mode)
        } else {
            mode = true
            loginview.singInOrSignUP(button1: signInOrUp, button2: signUpOrIn, mode: mode)
        }
    }
    
    @IBAction func signInOrUpPressed(_ sender: Any) {
        AlertIndicator.Instance.showActivityIndicator(theView: self.view) // start the activity indicator
        if mode==true {
            // signIn mode
            print("true mode")
            if(usernameTF.text != "" || passwordTF.text != ""){
//                PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!, block: { (user, err) in
//                    if err != nil{
//                        AlertIndicator.Instance.alertDisplay(viewController: self, title: "Error", message: "Please try again later")
//                        AlertIndicator.Instance.hideActivityIndicator()
//                        self.usernameTF.text = ""
//                        self.passwordTF.text = ""
//                    } else {
//                        AlertIndicator.Instance.hideActivityIndicator()
//                        self.performSegue(withIdentifier: "signToDashboard", sender: self)
//                    }
//                })
                
                AuthProvider.Instance.signIn(withEmail: usernameTF.text!, password: passwordTF.text!, loginhandler: { (message) in
                    if message != nil{
                        AlertIndicator.Instance.alertDisplay(viewController: self, title: "There was a problem", message: message!)
                        AlertIndicator.Instance.hideActivityIndicator()
                        self.usernameTF.text = ""
                        self.passwordTF.text = ""
                    } else {
                        AlertIndicator.Instance.hideActivityIndicator()
                        self.performSegue(withIdentifier: "signToDashboard", sender: self)
                    }
                })
                
            } else {
                AlertIndicator.Instance.hideActivityIndicator()
                AlertIndicator.Instance.alertDisplay(viewController: self, title: "Error", message: "Please fill all fields")
            }
        } else {
            // signUp mode
            if(usernameTF.text != nil && passwordTF.text != nil){
                let user = PFUser()
                user.username = usernameTF.text
                user.password = passwordTF.text
                user.email = usernameTF.text!+"@xyz.com"
                user.signUpInBackground(block: { (obj, err) in
                    if (err != nil) {
                        AlertIndicator.Instance.alertDisplay(viewController: self, title: "Error", message: err.debugDescription)
                        AlertIndicator.Instance.hideActivityIndicator()
                    }else{
                        AlertIndicator.Instance.hideActivityIndicator()
                        self.performSegue(withIdentifier: "signToDashboard", sender: self)
                    }
                })
            }else{
                AlertIndicator.Instance.alertDisplay(viewController: self, title: "Error", message: "Please fill all fields.")
            }
        }
    }
}
