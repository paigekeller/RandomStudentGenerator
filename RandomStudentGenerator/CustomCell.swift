//
//  CustomCell.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var classNameOutlet: UILabel!
    
    @IBOutlet weak var numStudentsOutlet: UILabel!
    
    func configure(name: String, number: Int) {
        classNameOutlet.text = name
        numStudentsOutlet.text = "\(number) students"
    }
    
    
    
}
