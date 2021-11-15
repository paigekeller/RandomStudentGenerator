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
    static var swap: Bool = false
    
    
    var colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.systemPink, UIColor.white, UIColor.systemTeal, UIColor.gray, UIColor.cyan, UIColor.magenta, UIColor.darkGray, UIColor.blue, UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.purple]
    var currentGroupNum = 0
    var groupsClass = Group()
    
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsClass.groups[currentGroupNum].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell2")!
     
        let temp: [String] = groupsClass.groups[currentGroupNum]
   
        cell.textLabel?.text = temp[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
        //swap
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    //SWAP STUDENT ACTION
    let swapAction = UITableViewRowAction(style: .normal, title: "Swap", handler: {action, indexPath in
        CustomCell2.swap = true
        self.groupsClass.swapIndx.0 = indexPath.row
        self.groupsClass.swapGroupNum.0 = self.currentGroupNum
        })
    
       swapAction.backgroundColor = UIColor.black
       
        return [swapAction]
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print(CustomCell2.swap)
        if CustomCell2.swap == true {
        groupsClass.swapIndx.1 = indexPath.row
        self.groupsClass.swapGroupNum.1 = currentGroupNum
        print(groupsClass.swapIndx)
        print(groupsClass.swapGroupNum)
            groupsClass.swap()
            CustomCell2.swap = false
            print("CELL SELECTED")
            GroupsViewController.groupsClass = self.groupsClass
            GroupsViewController.selected = true
        }
    }
        
    
    func configure(group: Group, groupNum: Int) {
        
        currentGroupNum = groupNum //lower number
        groupsClass = group
        tableview.delegate = self
        tableview.dataSource = self
        groupLabel.text = "Group: \(groupNum + 1)"
        groupLabel.backgroundColor = colors[groupNum]
        tableview.reloadData()
    }
}
