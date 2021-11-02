//
//  CustomCell2.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/17/21.
//

import UIKit

class CustomCell2: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
//    var totalGroups = 0 //assuming there are more students than groups
    var colors: [UIColor] = [UIColor.blue, UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.brown, UIColor.systemPink, UIColor.white, UIColor.systemTeal, UIColor.gray, UIColor.cyan, UIColor.magenta, UIColor.darkGray]
//    var students: [String] = []
    var currentGroupNum = 0
//    var leftover = 0 //number of students left over if they don't fit evenly into the groups
//    //going to put the left over students in groups starting from group 1 then going down
//    var LOAccountedFor: Int!
    var groupsClass = Group()
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (currentGroupNum+1) <= leftover {
//            return ((students.count/totalGroups)+1)
//        } else {
//        return (students.count/totalGroups) //truncates
//        }
        return groupsClass.groups[currentGroupNum].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell2")!
     
        let temp: [String] = groupsClass.groups[currentGroupNum]
   
        cell.textLabel?.text = temp[indexPath.row]
        
        return cell
    }
    
    
    func configure(group: Group, groupNum: Int) {
        
        currentGroupNum = groupNum
        groupsClass = group
//        students = s
//        totalGroups = tg
//        self.currentGroupNum = groupNum-1
        tableview.delegate = self
        tableview.dataSource = self
        groupLabel.text = "Group: \(groupNum + 1)"
        groupLabel.backgroundColor = colors[groupNum]
//        leftover = (students.count % totalGroups)
//        LOAccountedFor = leftover - currentGroupNum
        tableview.reloadData()
    }
}
