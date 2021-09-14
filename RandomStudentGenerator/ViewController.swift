//
//  ViewController.swift
//  RandomStudentGenerator
//
//  Created by Tiger Coder on 3/2/21.
//

import UIKit

class ViewController: UIViewController {

    let mySchedule = Schedule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
//
//        if mySchedule.allClasses.count == 0 {
//       for each in UserDefaults.standard.array(forKey: "myClasses") as! [Data] {
//            mySchedule.allClasses.append(each)
//        }
//        }
        
       
        
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

