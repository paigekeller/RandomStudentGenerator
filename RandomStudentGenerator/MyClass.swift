//
//  MyClass.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/10/21.
//

import Foundation
import UIKit

class MyClass: Codable {
    var students: [String] = []
    var className: String = ""
    // var randomSetting: String //true = keep student, false = remove student

    init(cn: String, s: [String]){
        className = cn
        students = s
    }
    
    init() {
        
    }
    
    
}
