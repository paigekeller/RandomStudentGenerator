//
//  ViewController.swift
//  RandomStudentGenerator
//
//  Created by Tiger Coder on 3/2/21.
//

import UIKit

class ViewController: UIViewController {

    static var mySchedule = Schedule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func myClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toMyClasses", sender: nil)
    }
    
    @IBAction func createClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateClass", sender: nil)
    }
    
    
}

