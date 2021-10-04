//
//  MyClassesVC.swift
//  RandomStudentGenerator
//
//  Created by PAIGE KELLER on 9/7/21.
//

import UIKit

class MyClassesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var createClassBtn: UIButton!
    
    let defaults = UserDefaults()
    var classes: [MyClass] = [] //decoding from user defualts and resaving
    var selectedClass: MyClass!
    var indexAt: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableview.delegate = self
        tableview.dataSource = self
        
        
    }
    
    @IBAction func unwindToMyClasses(_seg: UIStoryboardSegue) {
        print("unwinding home")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      classes = []
        do {
        let decoder = JSONDecoder()
            if let usdf = UserDefaults.standard.array(forKey: "classArray") {
            print("before loop")
            for each in usdf {
                print("inside loop")
        // Decode Class
                print(each)
            let temp = try decoder.decode(MyClass.self, from: each as! Data)
            classes.append(temp)
            print(temp)
    }
            }
        } catch {
            print("Error handing try")
        }
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
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        
        cell.configure(name: classes[indexPath.row].className, number: classes[indexPath.row].students.count)
        
        
        return cell
    }
    
}
