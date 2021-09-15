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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        createClassBtn.isHidden = true
        
        if classes.count == 0 {
            createClassBtn.isHidden = false
        }
        
        do {
        let decoder = JSONDecoder()

            print(UserDefaults.standard.array(forKey: "classArray")!.count)
            
            for each in UserDefaults.standard.array(forKey: "classArray")! {
            // Decode Class
            var temp = try decoder.decode(MyClass.self, from: each as! Data)
            classes.append(temp)
            print(temp)
    }
            
        } catch {
            print("Error handing try")
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The following call was selected")
        print(classes[indexPath.row].className)
        selectedClass = classes[indexPath.row]
        performSegue(withIdentifier: "toSelectedClass", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedClass" {
            let nvc = segue.destination as! SelectedClass
            nvc.selectedClass = self.selectedClass
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
