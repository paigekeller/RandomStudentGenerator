//
//  ViewController.swift
//  RandomStudentGenerator
//
//  Created by Tiger Coder on 3/2/21.
//

//my comment
//comment 2

import UIKit

@available(iOS 14.0, *)
class ViewController: UIViewController {

    let mySchedule = Schedule()
    @IBOutlet weak var myClsOutlet: UIButton!
    @IBOutlet weak var createOutlet: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("hello world")
        
        myClsOutlet.layer.cornerRadius = 20 //set corner radius here
        createOutlet.layer.cornerRadius = 20 //set corner radius here
        
    }

    
    @IBAction func unwindHome(_ seg: UIStoryboardSegue ) {
        print("unwinding home")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateClass" {
            let nvc = segue.destination as! CreateClass
            nvc.schedule = self.mySchedule
        }
    }
    
    
    @IBAction func myClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toMyClasses", sender: nil)
    }
    
    @IBAction func createClassAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateClass", sender: nil)
    }
    
    
}

