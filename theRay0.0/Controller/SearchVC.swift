//
//  SearchVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 06/05/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse

class SearchVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    var updatedSearchResultsArray = [Student]()
    let schoolName = PFUser.current()?.value(forKey: "schoolName")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTable.register(UINib(nibName: "SearchTVC", bundle: nil), forCellReuseIdentifier: "SearchCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedSearchResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTable.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchTVC else{
            return UITableViewCell()
        }
//        cell.nameLabel.text = "Rishabh Anand"
//        cell.classLabel.text = "08A"
        cell.nameLabel.text = updatedSearchResultsArray[indexPath.row].studentName
        cell.classLabel.text = updatedSearchResultsArray[indexPath.row].classId
        cell.studentImage.image = #imageLiteral(resourceName: "student")
        
        return cell
    }
}
