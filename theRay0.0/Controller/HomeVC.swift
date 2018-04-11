//
//  HomeVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 09/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let HomeStruct = homeCellStruct()
    @IBOutlet weak var homeCV: UICollectionView!
    override var prefersStatusBarHidden: Bool { return  true } // hides the status bar i.e; battery bar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeCV.register(UINib(nibName: "HomeCVC", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeStruct.homeCellText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCVC
        cell.homeCellLabel.text = HomeStruct.homeCellText[indexPath.row]
        cell.homeCellImage.image = HomeStruct.homeCellImages[indexPath.row]
        
        return cell
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
}
