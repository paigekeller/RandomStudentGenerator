//
//  Groups.swift
//  RandomStudentGenerator
//
//  Created by Paige Keller on 11/1/21.
//

import Foundation
import UIKit

class Group {
    var groups: [[String]] = []
    
    
//groups init
    init(students: [String], numGroups: Int) { // numGroups is actual number of groups
        var group: [String] = []
        let studentsPerGroup = students.count/numGroups
        let leftover = students.count % numGroups
        
    var i = 0
        while (i < numGroups) {
        group = [] //empty out group
            var spg = 0
        if (leftover == 0) { //fits evenly
            for each in students {
                print("inside of fits evenly")
                if (students.firstIndex(of: each)! >= i * studentsPerGroup && spg < studentsPerGroup) {
                    group.append(each)
                    spg += 1
            }
            }
            print(group)
            groups.append(group)
        } else if (i < leftover) { //leftover students in here
            
                for each in students {
                     if (students.firstIndex(of: each)! >= i * (studentsPerGroup + 1) && spg < studentsPerGroup + 1) {
                        group.append(each)
                        spg += 1
                }
                }
                print(group)

                groups.append(group)
                
                
            } else { //no leftover student
    
                for each in students {
                    if (students.firstIndex(of: each)! >= (i * studentsPerGroup) + leftover && spg < studentsPerGroup) {
                        group.append(each)
                        spg += 1
                    }
                }
                print(group)

                groups.append(group)
            }
            i += 1
        }
    } //bottom of init
    
    
    
    
    
 //students init
    init(students: [String], numStudents: Int) {
        var group: [String] = []
        let studentsPerGroup = numStudents
        let leftover = students.count % numStudents
        var numGroups = 0
        
        if leftover == 0 {
            numGroups = students.count/numStudents
        } else {
            print()
            numGroups = students.count/numStudents + 1
        }
        
        
    var i = 0
        while (i < numGroups) {
        group = [] //empty out group
            var spg = 0
        if (leftover == 0) { //fits evenly
            for each in students {
                print("inside of fits evenly")
                if (students.firstIndex(of: each)! >= i * studentsPerGroup && spg < studentsPerGroup) {
                    group.append(each)
                    spg += 1
            }
            }
            print(group)
            groups.append(group)
        } else { //leftover students in here
            //have left over in extra group at end
            
            print(i)
            print(numGroups)
            if i < numGroups-1 {
                
            for each in students {
                if (students.firstIndex(of: each)! >= i * studentsPerGroup && spg < studentsPerGroup) {
                    group.append(each)
                    spg += 1
                }
            }
            } else {
                print("IN EXTRA")
                for each in students {
                    if (students.firstIndex(of: each)! >= i * studentsPerGroup && spg < leftover) {
                        group.append(each)
                        spg += 1
                    }
                }
            }
            
                print(group)
                groups.append(group)
            }
            i += 1
        }
        
        
    }
    
    
    
//empty init
    init() {
        
    }
    
    
}
