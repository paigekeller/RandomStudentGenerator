//
//  ClassSettings.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/22/21.
//

import UIKit

class ClassSettings: UIViewController {

    var selectedClass: MyClass = MyClass()
    var indexAt: Int = 6
    var tempRS: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("new index at")
        print(indexAt)
        print(selectedClass.keepStudentSetting)
        print(selectedClass.className)
        // Do any additional setup after loading the view.
    }
    
    
    //DELETE BUTTON
    @IBAction func deleteAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are You Sure You Want To Delete This Class?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            var tempClassArray = UserDefaults.standard.array(forKey: "classArray") as? [Data]
            tempClassArray?.remove(at: self.indexAt)
          
            //restoring the array of all the classes
            UserDefaults.standard.set(tempClassArray, forKey: "classArray")
            
            print("successfully deleted")
            self.performSegue(withIdentifier: "unwindToMyClasses", sender: nil)
        })
        
        let noAction = UIAlertAction(title: "No", style: .default, handler:  { (_) in
            //nothing happens
        })
        alert.view.tintColor = UIColor.blue
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //EDIT CLASS NAME BUTTON
    @IBAction func editBtn(_ sender: UIButton) {
        let alert2 = UIAlertController(title: "Enter The New Name Of Your Class", message: nil, preferredStyle: .alert)
        alert2.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            let name = alert2.textFields![0].text!
                print("new name = \(name)")
                self.selectedClass.className = name
                
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    
                    print("successfully changed name")
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }

        })
        alert2.addAction(cancelAction)
        alert2.addAction(okAction)
        present(alert2, animated: true, completion: nil)
    }
    

    //CHANGE RANDOM SETTINGS
    @IBAction func changeBtn(_ sender: UIButton) {
        let alert3 = UIAlertController(title: "Randomize Settings", message: "Status of Students After Choosen", preferredStyle: .alert)
        let check = "✓"
        var action1: UIAlertAction!
        var action2: UIAlertAction!
        let action3 = UIAlertAction(title: "Done", style: .default, handler: nil)
        //checking for check mark :)
        if selectedClass.keepStudentSetting == "true" {
            
            action1 = UIAlertAction(title: "Keep Student \(check)", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "true"
                print("true")
            })
            action2 = UIAlertAction(title: "Remove Student", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "false"
                print("false")
            })
            
        } else if selectedClass.keepStudentSetting == "false" {
            
            action1 = UIAlertAction(title: "Keep Student", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "true"
                print("true")
            })
            action2 = UIAlertAction(title: "Remove Student \(check)", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "false"
                print("false")
            })
        }
        alert3.addAction(action1)
        alert3.addAction(action2)
        alert3.addAction(action3)
        present(alert3, animated: true, completion: nil)
    }
    

}
