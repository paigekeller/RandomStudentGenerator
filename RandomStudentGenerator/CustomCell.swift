//
//  CustomCell.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

@available(iOS 14.0, *)
class CustomCell: UITableViewCell {

    @IBOutlet weak var classNameOutlet: UILabel!
    
    @IBOutlet weak var numStudentsOutlet: UILabel!
    
    @IBOutlet weak var paintBtn: UIButton!
    
    var cellIndex: Int = 0
    
    func configure(name: String, number: Int, index: Int) {
        classNameOutlet.text = name
        numStudentsOutlet.text = "\(number) students"
        paintBtn.titleLabel?.text = ""
        cellIndex = index
    }
    
    @IBAction func paintAction(_ sender: UIButton) {
        MyClassesVC.cellInd = self.cellIndex
    }
    
}
