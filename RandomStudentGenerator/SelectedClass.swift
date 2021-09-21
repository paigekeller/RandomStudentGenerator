//
//  SelectedClass.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/15/21.
//

import UIKit

class SelectedClass: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var spotlight: UIImageView!
    @IBOutlet weak var studentChoosenLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var selectedClass: MyClass = MyClass()
    var indexAt: Int = 0
    let alert = UIAlertController(title: "Are You Sure You Want To Delete This Class?", message: nil, preferredStyle: .alert)
   
    let alert2 = UIAlertController(title: "New Student Name", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        classNameLabel.text = selectedClass.className
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    
    @IBAction func trashBtn(_ sender: UIButton) {
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
    
    @IBAction func randBtn(_ sender: UIButton) {
        var random = Int.random(in: 0...(selectedClass.students.count-1))
        
        studentChoosenLabel.text = selectedClass.students[random]
        
        spotlight.isHidden = false
        studentChoosenLabel.isHidden = false
        
    }
    

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
    //DELETE ACTION
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
            
            print("successfully removed student")
            
        } catch {
            print("Unable to Encode Class (\(error))")
        }
        
        })
    
    //EDIT ACTION
    let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {action, indexPath in
        
        self.alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.alert2.addTextField(configurationHandler: { textField in
            textField.placeholder = "enter name here"
                                    })
        self.alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = self.alert2.textFields?.first?.text {
                print("new name = \(name)")
            }
        }))
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
    
    

}
