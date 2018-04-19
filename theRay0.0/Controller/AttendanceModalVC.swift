//
//  AttendanceModalTVC.swift
//  theRay0.0
//
//  Created by Rishabh Anand on 17/04/18.
//  Copyright © 2018 Rishabh Anand. All rights reserved.
//

import UIKit

class AttendanceModalVC: UIViewController {

    
    @IBOutlet weak var studentsName: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.studentNamesTable.register("AttendanceModalTVCell", forCellReuseIdentifier: "AttendanceModalCell")
        
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceModalCell", for: indexPath) as! AttendanceModalTVCell
        
        return cell
    }
}
