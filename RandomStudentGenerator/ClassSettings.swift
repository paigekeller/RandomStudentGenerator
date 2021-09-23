//
//  ClassSettings.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/22/21.
//

import UIKit

class ClassSettings: UIViewController {

    var selectedClass: MyClass = MyClass()
    var indexAt: Int = 0
    let alert = UIAlertController(title: "Are You Sure You Want To Delete This Class?", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            var tempClassArray = UserDefaults.standard.array(forKey: "classArray") as? [Data]
            tempClassArray?.remove(at: self.indexAt)
          
            //restoring the array of all the classes
            UserDefaults.standard.set(tempClassArray, forKey: "classArray")
            
            print("successfully deleted")
            self.performSegue(withIdentifier: "toClass", sender: nil)
        })
        
        let noAction = UIAlertAction(title: "No", style: .default, handler:  { (_) in
            //nothing happens
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}
