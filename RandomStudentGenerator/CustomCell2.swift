//
//  CustomCell2.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/17/21.
//

import UIKit

class CustomCell2: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
   
    func configure(name: String, groupNum: Int) {
        groupLabel.text = "Group: \(groupNum)"
    }
}
