//
//  CreateClass.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

class CreateClass: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    

    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var studentName: UITextField!
    var classroomName: String = ""
    var studentsArray: [String] = []
    let defaults = UserDefaults()
    var schedule = Schedule()
    let alert = UIAlertController(title: "Invalid Entry", message: "Oops! Looks like you forgot to enter a class name!", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "Edit Student Name", message: nil, preferredStyle: .alert)
    let alert3 = UIAlertController(title: "Error \n Looks like you already have a student with that name!", message: nil, preferredStyle: .alert)
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        textfield.delegate = self
        textfield1.delegate = self
        tableview.rowHeight = 55
        
        let action1 = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action1)
        alert3.addAction(action1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                view.addGestureRecognizer(tap) // Add gesture recognizer to background view
    }
    
    @objc func handleTap() {
          textfield.resignFirstResponder() // dismiss keyoard
          textfield1.resignFirstResponder()
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        if className.text?.isEmpty == true {
            print("no")
            present(alert, animated: true)
        } else  {
        label.text = className.text
        classroomName = className.text!
        }
        className.text = ""
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        if studentName.text?.isEmpty == true {
            print("no")
            present(alert, animated: true)
        } else if checkNames(name: studentName.text!) == true {
            present(alert3, animated: true, completion: nil)
        } else {
            studentsArray.append("\(studentName.text!)")
            print("added")
        }
        tableview.reloadData()
        studentName.text = ""
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //DELETE STUDENT ACTION
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {action, indexPath in
            
            print("deleted")
            self.studentsArray.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    })
    //EDIT STUDENT ACTION
    let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {action, indexPath in
        
        if self.num == 0 {
        self.alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.alert2.addTextField(configurationHandler: { textField in
            textField.placeholder = "enter name here"
                                    })
        self.alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = self.alert2.textFields?.first?.text {
                print("new name = \(name)")
                self.studentsArray[indexPath.row] = name
                self.tableview.reloadData()
            }
        }))
        }
        self.num += 1
        
        self.present(self.alert2, animated: true)
        
        print("edited")
        
    })
        
    editAction.backgroundColor = UIColor.blue
    
       return [deleteAction, editAction]
   }
    
    
    
    
    @IBAction func saveClass(_ sender: UIButton) {
        if classroomName == "" {
            present(alert, animated: true)
        } else {
        let newclass = MyClass(cn: classroomName, s: studentsArray, ks: "true")
        var tempClassArray: [Data]!
        if UserDefaults.standard.array(forKey: "classArray") != nil {  //if it exists...
        tempClassArray = UserDefaults.standard.array(forKey: "classArray") as? [Data]
        } else {
            tempClassArray = []
            print("couldn't find classArray")
        }
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(newclass)
            tempClassArray.append(data)
            
            
            // Write/Set Data     //storing or restoring the array of all the classes
            UserDefaults.standard.set(tempClassArray, forKey: "classArray")
            
            print("success")
            
            // Read/Get Data
            let decoder = JSONDecoder()

            for each in UserDefaults.standard.array(forKey: "classArray")! {
                // Decode Class
                let newClass2 = try decoder.decode(MyClass.self, from: each as! Data)
                print(newClass2.className)
                print(newClass2.students)
                }
            
            
        } catch {
            print("Unable to Encode Class (\(error))")
        }
        performSegue(withIdentifier: "toMyClasses", sender: nil)
        }
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell")!
        
        cell.textLabel?.text = studentsArray[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "Futura", size: CGFloat(20))
        
        return cell
    }
    
    
    func checkNames(name: String) -> Bool {
        for each in studentsArray {
            if each == name {
                return true
            }
        }
        return false
    }
    
}

