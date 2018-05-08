//
//  SearchVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 06/05/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit
import Parse

class SearchVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    var studentResultsArray = [Student]()
    var updatedSearchResultsArray = [Student]()
    let schoolName = PFUser.current()?.value(forKey: "schoolName") as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTable.register(UINib(nibName: "SearchTVC", bundle: nil), forCellReuseIdentifier: "SearchCell")
        let query = PFQuery(className: "AttendanceInfo")
        query.whereKey("schoolName", contains: schoolName)
        query.findObjectsInBackground { (students, err) in
            
            if students?.count != 0{
                for (index,student) in students!.enumerated(){
                    print(index)
                    print(student.value(forKey: "uid"))
                    self.studentResultsArray[index].uId = student.value(forKey: "uid") as! String
//                    self.studentResultsArray[0].attendanceInfo = student.value(forKey: "attendance") as! [[String]]
//                    self.studentResultsArray[0].classId = student.value(forKey: "classId") as! String
//                    self.studentResultsArray[0].emailId = student.value(forKey: "emailId") as! String
//                    self.studentResultsArray[0].studentName = student.value(forKey: "studName") as! String
//                    self.studentResultsArray[0].uId = student.value(forKey: "uid") as! String
                }
            }else{
//                change the UI 1. remove the table 2. add a label with apropriate text
            }
            self.updatedSearchResultsArray = self.studentResultsArray
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { updatedSearchResultsArray = studentResultsArray; searchTable.reloadData(); return  }
        updatedSearchResultsArray = studentResultsArray.filter({ (stud) -> Bool in
            stud.studentName.lowercased().contains(searchText.lowercased())
        })
        searchTable.reloadData()
    }

//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//
//    }
    
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
