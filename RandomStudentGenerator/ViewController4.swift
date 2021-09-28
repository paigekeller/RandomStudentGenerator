//
//  ViewController4.swift
//  RandomStudentGenerator
//
//  Created by Paige Keller on 9/23/21.
//

import UIKit

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindHome", sender: nil)
        
    }
    

}
