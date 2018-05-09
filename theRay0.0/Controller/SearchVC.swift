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
    var stud = Student() // used while storing info for every student of the selected school
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
                for student in students!{
                    self.stud = Student()
                    self.stud.attendanceInfo = student.value(forKey: "attendance") as! [[Int]]
                    self.stud.classId = student.value(forKey: "classId") as! String
                    self.stud.emailId = student.value(forKey: "emailId") as! String
                    self.stud.studentName = student.value(forKey: "studName") as! String
                    self.stud.uId = student.value(forKey: "uid") as! String
                    self.updatedSearchResultsArray.append(self.stud)
                    self.studentResultsArray.append(self.stud)
                }
            }else{
//                change the UI 1. remove the table 2. add a label with apropriate text
            }
            self.searchTable.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            updatedSearchResultsArray = studentResultsArray
            searchTable.reloadData()
            return
        }
        updatedSearchResultsArray = studentResultsArray.filter({ stud -> Bool in
            stud.studentName.lowercased().contains(searchText.lowercased())
        })
        searchTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedSearchResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTable.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchTVC else{
            return UITableViewCell()
        }
        cell.nameLabel.text = updatedSearchResultsArray[indexPath.row].studentName
        cell.classLabel.text = updatedSearchResultsArray[indexPath.row].classId
        cell.studentImage.image = #imageLiteral(resourceName: "student")
        
        return cell
    }
}
