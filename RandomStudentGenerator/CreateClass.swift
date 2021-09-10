//
//  CreateClass.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

class CreateClass: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var studentName: UITextField!
    var classroomName: String = ""
    var studentsArray: [String] = []
    let defaults = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        if className.text?.isEmpty == true {
            print("no")
        } else  {
        label.text = className.text
        classroomName = className.text!
        }
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        if studentName.text?.isEmpty == true {
            print("no")
        } else  {
            studentsArray.append("\(studentName.text!)")
            print("added")
        }
        tableview.reloadData()
        
    }
    
    @IBAction func saveClass(_ sender: UIButton) {
        var newclass = MyClass(cn: classroomName, s: studentsArray)
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(newclass)

            ViewController.mySchedule.allClasses.append(data)
            
            // Write/Set Data
               defaults.set(ViewController.mySchedule.allClasses, forKey: "classArray")
            print("success")
        } catch {
            print("Unable to Encode Class (\(error))")
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! UITableViewCell
        
        cell.textLabel?.text = studentsArray[indexPath.row]
        
        return cell
    }
    
    
    
    
}
