//
//  SelectedClass.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/15/21.
//

import UIKit

// on unwind from class settings to this screen and myClasses screen no function, viewDidAppear or viewWillAppear, resets the screen




class SelectedClass: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var spotlight: UIImageView!
    @IBOutlet weak var studentChoosenLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var randBtn: UIButton!
    @IBOutlet weak var groupsBtn: UIButton!
    
    var num = 0
    var selectedClass: MyClass = MyClass()
    var indexAt: Int = 0
    let alert = UIAlertController(title: "Error \n Looks like you already have a student with that name!", message: nil, preferredStyle: .alert)
    let alert2 = UIAlertController(title: "Edit Student Name", message: nil, preferredStyle: .alert)
    let addStudentAlert = UIAlertController(title: "Add Student", message: nil, preferredStyle: .alert)
    
    var students: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsBtn.backgroundColor = UIColor.systemBrown
        groupsBtn.titleLabel?.font = UIFont(name: "Marker Felt", size: 13)
        
        classNameLabel.text = selectedClass.className
        tableview.delegate = self
        tableview.dataSource = self
        print(indexAt)
        addStudentAlert.addTextField()
        let cancelAct = UIAlertAction(title: "Cancel", style: .default, handler: {action in
            self.addStudentAlert.textFields![0].text = ""
        })
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let addAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
            let newName = self.addStudentAlert.textFields![0].text!
            if self.checkNames(name: newName) == false {
            self.selectedClass.students.append(newName)
            self.students = self.selectedClass.students
            self.tableview.reloadData()
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
            self.addStudentAlert.textFields![0].text = ""
            } else {
                self.present(self.alert, animated: true, completion: nil)
            }
        })
        addStudentAlert.addAction(cancelAct)
        addStudentAlert.addAction(addAction)
        alert.addAction(okAction)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        classNameLabel.text = selectedClass.className
        students = selectedClass.students
        print("Hello World")
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSettings" {
    let nvc = segue.destination as! ClassSettings
    nvc.selectedClass = self.selectedClass
    nvc.indexAt = self.indexAt
    } else if segue.identifier == "toGroups" {
        self.students = self.selectedClass.students
        let nvc = segue.destination as! GroupsViewController
        nvc.studentsArray = self.students
    }
   }
    
    
    @IBAction func unwindToSelectedClass(_ seg: UIStoryboardSegue ) {
        print("unwinding to my class")
    }
    
    @IBAction func BBSettingAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        present(addStudentAlert, animated: true)
    }
    
    
    
    
    @IBAction func randBtn(_ sender: UIButton) {
        
        if randBtn.imageView?.image == UIImage(named: "resetbuttonPic")! {
            
            students = selectedClass.students
            spotlight.isHidden = true
            studentChoosenLabel.text = ""
            let image = UIImage(named: "fullRandBtn")
            randBtn.setImage(image, for: .normal)
            
        } else {
            
        if students.count != 0 {
        if selectedClass.keepStudentSetting == "true" {
        let random = Int.random(in: 0...(selectedClass.students.count-1))
        
        studentChoosenLabel.text = selectedClass.students[random]
        
        spotlight.isHidden = false
        studentChoosenLabel.isHidden = false
        } else {
            
            print("false: remove student")
            let random = Int.random(in: 0...(students.count-1))
            studentChoosenLabel.text = students[random]
            if students.count != 1{
            students.remove(at: random)
            } else { //does = 1
                
                let image = UIImage(named: "resetbuttonPic")
                randBtn.setImage(image, for: .normal)
            }
            
            spotlight.isHidden = false
            studentChoosenLabel.isHidden = false
        }
      }
        }
    }
    

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //DELETE STUDENT ACTION
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {action, indexPath in
            
            print("deleted")
            self.selectedClass.students.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .automatic)

        var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
        
        do {
        let encoder = JSONEncoder()
            let data = try encoder.encode(self.selectedClass)
        tempClassArray?[self.indexAt] = data
            UserDefaults.standard.set(tempClassArray, forKey: "classArray")
            self.students = self.selectedClass.students
            print("successfully removed student")
            
        } catch {
            print("Unable to Encode Class (\(error))")
        }
        
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
                self.selectedClass.students[indexPath.row] = name
            
                var tempClassArray = UserDefaults.standard.array(forKey: "classArray")
                
                do {
                let encoder = JSONEncoder()
                    let data = try encoder.encode(self.selectedClass)
                tempClassArray?[self.indexAt] = data
                    UserDefaults.standard.set(tempClassArray, forKey: "classArray")
                    self.tableview.reloadData()
                    print("successfully changed name")
                    self.students = self.selectedClass.students
                    
                } catch {
                    print("Unable to Encode Class (\(error))")
                }
                
                
                
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedClass.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell")!
        
        cell.textLabel?.font = UIFont(name: "Futura", size: CGFloat(18))
        
        cell.textLabel?.text = selectedClass.students[indexPath.row]
        
    
        
        return cell
    }
    
    func checkNames(name: String) -> Bool {
        for each in students {
            if each == name {
                return true
            }
        }
        return false
    }

}
