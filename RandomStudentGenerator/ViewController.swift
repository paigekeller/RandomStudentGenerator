//
//  ViewController.swift
//  RandomStudentGenerator
//
//  Created by Tiger Coder on 3/2/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func myClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toMyClasses", sender: nil)
    }
    
    @IBAction func createClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateClass", sender: nil)
    }
    
    
}

