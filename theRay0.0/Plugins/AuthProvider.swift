//
//  AuthProvider.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 06/05/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import Foundation
import Parse

class AuthProvider{
    typealias LoginHandler = (_ message: String?) -> Void;
    struct errorCodes {
        static let USERNAME_EMPTY = "Username field is empty!"
        static let PASSWORD_EMPTY = "Password field is empty!"
        static let INVALID_USERNAME = "Username is not valid, Please enter a valid one"
        static let USER_NOT_FOUND = "User not found, Please register"
        static let USERNAME_ALREADY_IN_USE = "This username is already registered, Please use another Username"
        static let PROBLEM_IN_CONNECTION = "Problem connecting to server, Please try again later"
    }
    private static let _instance = AuthProvider()
    static var Instance: AuthProvider{
        return _instance
    }
    func signIn(withEmail: String, password: String, loginhandler: LoginHandler?){
        PFUser.logInWithUsername(inBackground: withEmail, password: password) { (user, err) in
            if err != nil{
                // there was some problem
                self.handleErrors(err: err as! NSError, loginHandler: loginhandler)
            } else {
                // all O.K., logged in
                loginhandler!(nil)
                
            }
        }
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?){
        if err != nil{
            let errCode = err.code
            switch errCode {
            case 100:
                loginHandler?(errorCodes.PROBLEM_IN_CONNECTION)
            case 101:
                loginHandler?(errorCodes.INVALID_USERNAME)
            case 200:
                loginHandler?(errorCodes.USERNAME_EMPTY)
            case 201:
                loginHandler?(errorCodes.PASSWORD_EMPTY)
            case 202:
                loginHandler?(errorCodes.USERNAME_ALREADY_IN_USE)
            case 205:
                loginHandler?(errorCodes.USER_NOT_FOUND)
            default:
                loginHandler?(errorCodes.PROBLEM_IN_CONNECTION)
            }
            
        }
    }
}
