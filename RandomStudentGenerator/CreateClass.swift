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
    var schedule = Schedule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = 55
        
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        if className.text?.isEmpty == true {
            print("no")
        } else  {
        label.text = className.text
        classroomName = className.text!
        }
        className.text = ""
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        if studentName.text?.isEmpty == true {
            print("no")
        } else  {
            studentsArray.append("\(studentName.text!)")
            print("added")
        }
        tableview.reloadData()
        studentName.text = ""
    }
    
    @IBAction func saveClass(_ sender: UIButton) {
        let newclass = MyClass(cn: classroomName, s: studentsArray)
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
        
        performSegue(withIdentifier: "unwindHome", sender: nil)
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
    
    
    
    
}
