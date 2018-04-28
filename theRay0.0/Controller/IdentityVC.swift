//
//  IdentityVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 02/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class IdentityVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var signInBtn: UIButton!
    var rowNum = Int()
    let identity = Identity() // for storing the identities
    @IBOutlet weak var idTypeCollection: UICollectionView! // the view
    override var prefersStatusBarHidden: Bool { return  true } // hides the status bar i.e; battery bar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTypeCollection.register(UINib(nibName: "IndentityCVC", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return identity.identitiesName.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = idTypeCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IndentityCVC
        cell.identityText.text = identity.identitiesName[indexPath.row]
        cell.identityBackground.image = identity.identitiesPic[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "identityToSign"){
            let receivingView = segue.destination as! LoginVC
            receivingView.identityFrmSegue = (identity.identitiesName[rowNum])
            receivingView.mode = false
        }
        if(segue.identifier == "signInSegue"){
            let receivingView = segue.destination as! LoginVC
            receivingView.identityFrmSegue = ""
            receivingView.mode = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rowNum = indexPath.row
        performSegue(withIdentifier: "identityToSign", sender: self)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "signInSegue", sender: self)
    }
}
