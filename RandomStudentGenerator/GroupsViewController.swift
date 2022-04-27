//
//  GroupsClass.swift
//  RandomStudentGenerator
//
//  Created by Paige Keller on 10/28/21.
//

import UIKit

class GroupsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var reRandBtn: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var groupsBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var studentsBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var titleOutlet: UILabel!
    let alertName = UIAlertController(title: "Enter Name", message: "Please enter the name you would like to save your groups under", preferredStyle: .alert)
    var cancelBool: Bool = false
    var greenTracker = 0
    var swap: Bool = false
    static var newGroup = Group()
    var array = ["Number Of Groups/Students","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    var numGroups: Int = 0
    var numStudents: Int = 0
    var studentsArray: [String] = []
    var randStudentsArray: [String] = []
    let alert = UIAlertController(title: "Woops... \n You don't have enough students for this number!", message: nil, preferredStyle: .alert)
    var numPickerAt = 0
    static var selected = false
    var myClass: MyClass = MyClass()
    var groupName: String = ""
    var classes: [MyClass] = []
    var segueFrom: String = ""
    
    var groupIndx: Int = 0
    var selectedGroup: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(groupIndx)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        randStudentsArray = studentsArray.shuffled()
        print(randStudentsArray)
        alertName.addTextField()
        let action2 = UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            
            self.cancelBool = true
            
        })
        alertName.addAction(action2)
        let action1 = UIAlertAction(title: "Enter", style: .default, handler: {_ in
            
            self.groupName = self.alertName.textFields![0].text!
            
            
            var tempIndx = 0
            
            do {
                
            let decoder = JSONDecoder()
                if let usdf = UserDefaults.standard.array(forKey: "classArray") {
               
                    var i = 0
                for each in usdf {
            // Decode Class
                let clas = try decoder.decode(MyClass.self, from: each as! Data)
                    self.classes.append(clas)
                    if clas.className == self.myClass.className {
                        tempIndx = i
                    }
                    i += 1
                    
                }
                }
            } catch {
                print("Error handing try")
            }
            
            
            self.myClass.groups.append(GroupsViewController.newGroup)
            self.classes[tempIndx] = self.myClass
            self.myClass.groups[self.myClass.groups.count-1].name = self.groupName
            
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                var dataArray: [Data] = []
                
                
                for each in self.classes {
                // Encode Note
                let data = try encoder.encode(each)
                dataArray.append(data)


                // Write/Set Data     //storing or restoring the array of all the classes
                UserDefaults.standard.set(dataArray, forKey: "classArray")

                print("success")
                }

            } catch {
                print("Unable to Encode Class (\(error))")
            }
            
            //print(UserDefaults.standard.array(forKey: "classArray")![tempIndx])
            
    //
                                    
            self.performSegue(withIdentifier: "unwindG", sender: nil)
            
        })
        alertName.addAction(action1)
        
        picker.isHidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tableview.delegate = self
        tableview.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveBtn.titleLabel?.textColor = UIColor.white
        if segueFrom == "ToViewGroup" {
            selectedGroup = myClass.groups[groupIndx]
            print("inside")
            titleOutlet.text = selectedGroup.name
            pickerView.isHidden = true
            groupsBtn.isHidden = true
            studentsBtn.isHidden = true
            label1.isHidden = true
            label2.isHidden = true
            
        }
    }
   
    @IBAction func groups(_ sender: UIButton) {
        if greenTracker == -1 || greenTracker == 0 {
            groupsBtn.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.70, alpha: 1)
            studentsBtn.backgroundColor = UIColor.systemTeal

        }
        if greenTracker != 0 && numPickerAt != 0 && greenTracker != 1 {
            
                if numPickerAt > studentsArray.count {
                present(alert, animated: true, completion: nil)
            } else {
                GroupsViewController.newGroup = Group(students: randStudentsArray, numGroups: numPickerAt)
            greenTracker = 1
            tableview.reloadData()
            }
        }
        picker.isHidden = false
            greenTracker = 1
    }
    
    @IBAction func students(_ sender: UIButton) {
        if greenTracker == 1 || greenTracker == 0 {
            studentsBtn.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.70, alpha: 1)
            groupsBtn.backgroundColor = UIColor.systemTeal
            
        }
        if greenTracker != 0 && numPickerAt != 0 && greenTracker != -1 {
            
            
                if numPickerAt > studentsArray.count {
                present(alert, animated: true, completion: nil)
                } else {
                    GroupsViewController.newGroup = Group(students: randStudentsArray, numStudents: numPickerAt)
            greenTracker = -1
            tableview.reloadData()
            }
        }
        picker.isHidden = false
        greenTracker = -1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numPickerAt = row + 1
        print(numPickerAt)
        if row != 0 {
        if greenTracker == 1 { // sort by groups
            numGroups = Int(array[row])!
            print(numGroups)
            GroupsViewController.newGroup = Group(students: randStudentsArray, numGroups: numPickerAt)
        } else if greenTracker == -1 { //sort by students
            numStudents = Int(array[row])!
            print(numStudents)
            GroupsViewController.newGroup = Group(students: randStudentsArray, numStudents: numPickerAt)
        }
            if numPickerAt > studentsArray.count {
            present(alert, animated: true, completion: nil)
        } else {
        tableview.reloadData()
        }
            
        }
        
        reRandBtn.isHidden = false
        saveBtn.isHidden = false
    }

    @IBAction func reRandomize(_ sender: UIButton) {
        
        randStudentsArray = randStudentsArray.shuffled()
        if greenTracker == -1 {
            GroupsViewController.newGroup = Group(students: randStudentsArray, numStudents: numPickerAt)
            tableview.reloadData()
        } else if greenTracker == 1 {
            GroupsViewController.newGroup = Group(students: randStudentsArray, numGroups: numPickerAt)
            tableview.reloadData()
        }
       
    }

    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print("TAPPED!")
        if (GroupsViewController.selected == true ) {
            tableview.reloadData()
            print("reloaded")
            GroupsViewController.selected = false
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (greenTracker == 1) { //groups
            return numPickerAt
        }
        else if greenTracker == -1 { //students
            if studentsArray.count % numPickerAt == 0 {
                    return (studentsArray.count/numPickerAt)
            } else {
                return ((studentsArray.count/numPickerAt) + 1)
            }
        } else if segueFrom == "ToViewGroup" { //viewing a group
            return selectedGroup.groups.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segueFrom != "ToViewGroup" {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell2
        
        
        cell.configure(group: GroupsViewController.newGroup, groupNum: indexPath.row)
        
        return cell
        } else {
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell2
           
            cell.configure(g: selectedGroup, groupNum: indexPath.row, word: "word")
           
            return cell
            
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        present(alertName, animated: true, completion: nil)
        
        
        
    }
    
    
}
