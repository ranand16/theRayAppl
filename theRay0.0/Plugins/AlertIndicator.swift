//
//  alertIndicator.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 28/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class AlertIndicator{
    private static let _instance = AlertIndicator()
    
    static var Instance: AlertIndicator{
        return _instance
    }
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    func showActivityIndicator(theView: UIView){
        activityIndicator.center = theView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        theView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func alertDisplay(viewController: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            viewController.dismiss(animated: true, completion: nil)
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
