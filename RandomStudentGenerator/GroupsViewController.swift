//
//  GroupsClass.swift
//  RandomStudentGenerator
//
//  Created by Paige Keller on 10/28/21.
//

import UIKit

class GroupsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var reRandBtn: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var groupsBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var studentsBtn: UIButton!
    var greenTracker = 0
    var groupsClass = Group()
    var array = ["Number Of Groups/Students","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    var numGroups: Int = 0
    var numStudents: Int = 0
    var studentsArray: [String] = []
    var randStudentsArray: [String] = []
    let alert = UIAlertController(title: "Woops... \n You don't have enough students for this number!", message: nil, preferredStyle: .alert)
    var numPickerAt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        randStudentsArray = studentsArray.shuffled()
        print(randStudentsArray)
        
        picker.isHidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tableview.delegate = self
        tableview.dataSource = self
        
        // Do any additional setup after loading the view.
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
            groupsClass = Group(students: randStudentsArray, numGroups: numPickerAt)
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
            groupsClass = Group(students: randStudentsArray, numStudents: numPickerAt)
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
            groupsClass = Group(students: randStudentsArray, numGroups: numPickerAt)
        } else if greenTracker == -1 { //sort by students
            numStudents = Int(array[row])!
            print(numStudents)
            groupsClass = Group(students: randStudentsArray, numStudents: numPickerAt)
        }
            if numPickerAt > studentsArray.count {
            present(alert, animated: true, completion: nil)
        } else {
        tableview.reloadData()
        }
            
        }
        
        reRandBtn.isHidden = false
    }

    @IBAction func reRandomize(_ sender: UIButton) {
        
        randStudentsArray = randStudentsArray.shuffled()
        if greenTracker == -1 {
        groupsClass = Group(students: randStudentsArray, numStudents: numPickerAt)
            tableview.reloadData()
        } else if greenTracker == 1 {
            groupsClass = Group(students: randStudentsArray, numGroups: numPickerAt)
            tableview.reloadData()
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
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell2
        
        
        cell.configure(group: groupsClass, groupNum: indexPath.row)
        
        return cell
    }
    
    
}
