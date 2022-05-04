//
//  MyClassesVC.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

extension UserDefaults {
    func setColor(color: UIColor?) -> NSData? {
        var colorData: NSData?
        if let color = color {
            do {
                colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false ) as NSData?
                return colorData

            } catch let err {
                print("error archiving colorData", err)
            }
        }
        return colorData
    }
    
    func colorForKey(data: NSData?) -> UIColor? {
        var color: UIColor?
        do {
            color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data! as Data)
        } catch let err {
            print("error unarchiving colorData", err)
        }
        return color
    }
    
}




@available(iOS 14.0, *)
class MyClassesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var sortBtn: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    
    let defaults = UserDefaults()
    var classes: [MyClass] = [] //decoding from user defualts and resaving
    var classColors: [UIColor] = [] //parallel array to ^
    var temp: [NSData?] = []
    var selectedClass: MyClass!
    var indexAt: Int!
    static var cellInd: Int = 0
    var fromNewClass: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.layer.cornerRadius = 15 //set corner radius here
        
        tableview.delegate = self
        tableview.dataSource = self

    }
    
    
    @IBAction func unwindToMyClasses(_seg: UIStoryboardSegue) {
        print("unwinding home")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        classes = []
        classColors = []
       
        do {
        let decoder = JSONDecoder()
        
            if let usdf = UserDefaults.standard.array(forKey: "classArray") {
            print("before loop")
            for each in usdf {
                print("inside loop")
        // Decode Class
                let temp = try decoder.decode(MyClass.self, from: each as! Data)
                    
                
            classes.append(temp)
                print(classes.count)
    }
            }
        } catch {
            print("Error handing try")
    
        }
   
        
        if UserDefaults.standard.array(forKey: "colors") == nil { //if it doesn't exist
            print("INSIDE DOESNT EXIST")
            for _ in classes {
                classColors.append(UIColor.white) //making an all white array
            }
                for each in classColors { //setting each color to data
                    temp.append(UserDefaults.standard.setColor(color: each))
                    print("here")
                }
                UserDefaults.standard.set(temp, forKey: "colors")
                print("saved!")
            temp = UserDefaults.standard.array(forKey: "colors") as! [NSData]
        } else if fromNewClass == true {
            temp = UserDefaults.standard.array(forKey: "colors") as! [NSData]
            temp.append(UserDefaults.standard.setColor(color: UIColor.white))
            print("here")
            UserDefaults.standard.set(temp, forKey: "colors")
            fromNewClass = false
            for each in temp {
                classColors.append(UserDefaults.standard.colorForKey(data: each)!)
            }
        } else {
            print("INSIDE ELSEEEE")
            temp = UserDefaults.standard.array(forKey: "colors") as! [NSData]
            for each in temp {
                classColors.append(UserDefaults.standard.colorForKey(data: each)!)
            }
        }
        
        
        print("HJDgXCHIUJKHWJIU")
        print(temp.count)
        tableview.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The following class was selected")
        print(classes[indexPath.row].className)
        selectedClass = classes[indexPath.row]
        indexAt = indexPath.row
        performSegue(withIdentifier: "toSelectedClass", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedClass" {
            let nvc = segue.destination as! SelectedClass
            nvc.selectedClass = self.selectedClass
            nvc.indexAt = self.indexAt
            nvc.temp = self.temp
        } else if segue.identifier == "toSettings" {
            let nvc = segue.destination as! ClassSettings
            nvc.selectedClass = self.selectedClass
            nvc.indexAt = self.indexAt
            nvc.fromListView = true
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(classes.count)
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        
        cell.configure(name: classes[indexPath.row].className, number: classes[indexPath.row].students.count, index: indexPath.row)
        
        cell.paintBtn.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)

        //decode ud here
        print(temp.count)
        print(classes.count)
        cell.backgroundColor = UserDefaults.standard.colorForKey(data: temp[indexPath.row])
       
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //settings edit
        let deleteAction = UITableViewRowAction(style: .normal, title: "Settings", handler: {action, indexPath in
            self.selectedClass = self.classes[indexPath.row]
            self.indexAt = indexPath.row
            self.performSegue(withIdentifier: "toSettings", sender: nil)
        })
    
        return [deleteAction]
    }
    
//color stuff
    @objc private func didTapSelectColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        print(MyClassesVC.cellInd)
        
        classColors[MyClassesVC.cellInd] = color
        
        temp = []
        for each in classColors { //setting each color to data
            temp.append(UserDefaults.standard.setColor(color: each))
        }
        UserDefaults.standard.set(temp, forKey: "colors")
        print("saved!")
        tableview.reloadData()
        
    }
    
    
    @IBAction func didTapSort() {
        if tableview.isEditing {
            tableview.isEditing = false
            sortBtn.title = "Sort"
            print("1")
        } else {
            tableview.isEditing = true
            sortBtn.title = "Done"
            print("2")
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//moving cells
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         
         //have to get the class
         let classToMove = classes[sourceIndexPath.row]
         let colorToMove = classColors[sourceIndexPath.row]
         
         
         //delete old class location
         classes.remove(at: sourceIndexPath.row)
         classColors.remove(at: sourceIndexPath.row)
         //add class to new spot
         classes.insert(classToMove, at: destinationIndexPath.row)
         classColors.insert(colorToMove, at: destinationIndexPath.row)
         
//         //delete old class location
//         classes.remove(at: sourceIndexPath.row)
//         classColors.remove(at: sourceIndexPath.row)
         
         var tempData: [Data] = []
         do {
             // Create JSON Encoder
             let encoder = JSONEncoder()
             
             for each in classes {
             // Encode Note
             let data = try encoder.encode(each)
             tempData.append(data)
             }
         }catch{
             print("Unable to Encode Class (\(error))")

         }

             temp = []
             for each in classColors {
                 temp.append(UserDefaults.standard.setColor(color: each))
             }
             
         UserDefaults.standard.set(tempData, forKey: "classArray")
         UserDefaults.standard.set(temp, forKey: "colors")
         
         tableView.reloadData()
    }
    
    
    
}
