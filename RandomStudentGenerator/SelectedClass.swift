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
    let alert = UIAlertController(title: "Are You Sure You Want To Delete This Class?", message: "", preferredStyle: .alert)
    
    
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
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedClass.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell")!
        
        cell.textLabel?.text = selectedClass.students[indexPath.row]
        
        return cell
    }
    
    

}
