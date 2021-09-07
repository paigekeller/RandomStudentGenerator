//
//  MyClassesVC.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

class MyClassesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var createClassBtn: UIButton!
    
    var classes: [String] = []
    var numbers: [Int] = [] //parallel arrays
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createClassBtn.isHidden = true
        
        if classes.count == 0 {
            createClassBtn.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        
        cell.configure(name: classes[indexPath.row], number: numbers[indexPath.row])
        
        
        return cell
    }
    
}
