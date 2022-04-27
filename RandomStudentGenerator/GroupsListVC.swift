//
//  GroupsListVC.swift
//  RandomStudentGenerator
//
//  Created by Paige Keller on 4/7/22.
//

import UIKit

class GroupsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    //let groups = UserDefaults.standard.array(forKey: "groupsArray") as! [Data]
    var myClass: MyClass = MyClass()
    var indx = 0
    var selectedGroupIndx: Int = 0
    var classes: [MyClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tempArray: [MyClass] = []
        
        do {
        for each in UserDefaults.standard.array(forKey: "classArray")! {
             //Read/Get Data
                       let decoder = JSONDecoder()
           
                           // Decode Class
                           let newClass2 = try decoder.decode(MyClass.self, from: each as! Data)
            tempArray.append(newClass2)
        }
                   } catch {
                       print("Unable to Encode Class (\(error))")
                   }
      
        myClass = tempArray[indx]
        print("inside list vc")
        print(myClass.groups.count)
        tableview.reloadData()
        
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToGroupsList(_seg: UIStoryboardSegue) {
        print("unwinding to listView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
        print(myClass.className)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMakeGroup" {
        let nvc = segue.destination as! GroupsViewController
        nvc.studentsArray = self.myClass.students
        nvc.myClass = self.myClass
            nvc.segueFrom = "ToMakeGroup"
        } else if segue.identifier == "ToViewGroup" {
            let nvc = segue.destination as! GroupsViewController
            nvc.myClass = self.myClass
            print("*********")
            nvc.groupIndx = self.selectedGroupIndx
            nvc.segueFrom = "ToViewGroup"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGroupIndx = indexPath.row
        performSegue(withIdentifier: "ToViewGroup", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClass.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell")!
        
        
        cell.textLabel?.font = UIFont(name: "Futura", size: 15)
        print(myClass.groups.count)
        cell.textLabel?.text = myClass.groups[indexPath.row].name
        
        
        return cell
    }
    
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
       //DELETE STUDENT ACTION
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {action, indexPath in
            
            print("deleted")
        self.myClass.groups.remove(at: indexPath.row)
        self.tableview.deleteRows(at: [indexPath], with: .automatic)
        
        self.classes = []
        
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
        
        
        self.classes[tempIndx] = self.myClass
        
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
        
        
        
        })
       
       return [deleteAction]
   }
    
    
    

}
