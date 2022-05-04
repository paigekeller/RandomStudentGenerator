//
//  ClassSettings.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/22/21.
//

import UIKit

class ClassSettings: UIViewController {

    @IBOutlet weak var randSettingsBtn: UIButton!
    @IBOutlet weak var classNameBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    var selectedClass: MyClass = MyClass()
    var indexAt: Int = 0
    var fromListView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randSettingsBtn.layer.cornerRadius = 15
        classNameBtn.layer.cornerRadius = 15
        deleteBtn.layer.cornerRadius = 15
       
        print("new index at")
        print(indexAt)
        print(selectedClass.keepStudentSetting)
        print(selectedClass.className)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        if fromListView == true {
            performSegue(withIdentifier: "backToList", sender: nil)
        } else {
            performSegue(withIdentifier: "backToSelected", sender: nil)
        }
        
    }
    
    
    @IBAction func doneBtn(_ sender: UIButton) {
        
        if fromListView == true {
            performSegue(withIdentifier: "backToList", sender: nil)
        } else {
            performSegue(withIdentifier: "backToSelected", sender: nil)
        }
        
    }
    
    
    
    
    
    
    //DELETE BUTTON
    @IBAction func deleteAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are You Sure You Want To Delete This Class?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            var tempClassArray = UserDefaults.standard.array(forKey: "classArray") as? [Data]
            tempClassArray?.remove(at: self.indexAt)
            var tempColorArray = UserDefaults.standard.array(forKey: "colors") as? [Data]
            tempColorArray?.remove(at: self.indexAt)
            
            //restoring the array of all the classes
            UserDefaults.standard.set(tempClassArray, forKey: "classArray")
            UserDefaults.standard.set(tempColorArray, forKey: "colors")
            
            
            print("successfully deleted")
            self.performSegue(withIdentifier: "backToList", sender: nil)
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
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
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    print("successfully added student")
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }
                print("true")
            })
            action2 = UIAlertAction(title: "Remove Student", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "false"
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    print("successfully added student")
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }
                print("false")
            })
            
        } else if selectedClass.keepStudentSetting == "false" {
            
            action1 = UIAlertAction(title: "Keep Student", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "true"
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    print("successfully added student")
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }
                print("true")
            })
            action2 = UIAlertAction(title: "Remove Student \(check)", style: .default, handler: { action in
                
                self.selectedClass.keepStudentSetting = "false"
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    print("successfully added student")
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }
                print("false")
            })
        }
        alert3.addAction(action1)
        alert3.addAction(action2)
        alert3.addAction(action3)
        present(alert3, animated: true, completion: nil)
    }
    
    
    
    

}
