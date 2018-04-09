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
    var mode: Bool = true {
        didSet(newValue) {
            if(newValue == true){
                signInOrUp.setTitle("SignIn",for: .normal)
                signUpOrIn.setTitle("SignUp",for: .normal)
            } else {
                signInOrUp.setTitle("SignUp",for: .normal)
                signUpOrIn.setTitle("SignIn",for: .normal)
            }
        }
    }
    // for toggling the signUp or signIn true...SignIn false...SignUp
    var identityFrmSegue = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if identityFrmSegue != ""{
            mode = false
            signUpAs.text = "Sign Up as \(identityFrmSegue)"
            signInOrUp.setTitle("SignUp",for: .normal)
            signUpOrIn.setTitle("SignIn",for: .normal)
        }
    }
    
    func alertDisplay(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpOrInPressed(_ sender: Any) {
        if mode{
            mode = false
        } else {
            mode = true
        }
    }
    
    @IBAction func signInOrUpPressed(_ sender: Any) {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        if mode {
            // signIn mode
            if(usernameTF.text != nil && passwordTF.text != nil){
                PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!, block: { (user, err) in
                    if err != nil{
                        self.alertDisplay(title: "Error", message: "Please try again later")
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.usernameTF.text = ""
                        self.passwordTF.text = ""
                    } else {
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.performSegue(withIdentifier: "signToDashboard", sender: self)
                    }
                })
                
            } else {
                self.alertDisplay(title: "Error", message: "Please fill all the fields.")
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
                        print("We had an error while signup", err.debugDescription)
                        self.alertDisplay(title: "Error", message: err.debugDescription)
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }else{
                        print("Succesfully cretead the user")
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.performSegue(withIdentifier: "signToDashboard", sender: self)
                    }
                })
            }else{
                self.alertDisplay(title: "Error", message: "Please fill all the fields.")
            }
        }
    }
}





