//
//  TimeTableSelectorViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 13..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class TimeTableSelectorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
  
    
    
    
    
    
    
    var courses = [Courses]()
    var numberOfselected = [Int]()
    var checked = [Bool]()
    //var selectedCourses = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadCourses()
        
        initialization()
        
        
       

        // Do any additional setup after loading the view.
    }
    //day1 string을 int로 casting 못하는 것 같다 알아볼것!
    
    func loadCourses() {
        Database.database().reference().child("courses").observe(.childAdded) { (snapshot : DataSnapshot) in
            if let dict = snapshot.value as? [String: Any]{
                
                let courseName = dict["cname"] as! String
                let courseRoom = dict["room"] as! String
                let courseInstructor = dict["instructor"] as! String
                let day1 = dict["day1"] as! Int
                let day2 = dict["day2"] as! Int
                let startHour1 = dict["startHour1"] as! Int
                let startMin1 = dict["startMin1"] as! Int
                let endHour1 = dict["endHour1"] as! Int
                let endMin1 = dict["endMin1"] as! Int
                let startHour2 = dict["startHour2"] as! Int
                let startMin2 = dict["startMin2"] as! Int
                let endHour2 = dict["endHour2"] as! Int
                let endMin2 = dict["endMin2"] as! Int
                //let day1 = dict["day1"] as! String
                
                //print(day1)
                
                
                /*let day1 = dict["time"] as! Int
                let day2 = dict["time"] as! Int*/
                
                
                let courseCode = snapshot.ref.key
                
                
                let courses = Courses(courseCodeText: courseCode, courseText: courseName, courseRoomText: courseRoom, courseInstructorText: courseInstructor, day1Text: day1, day2Text: day2, startHour1Text: startHour1, startMin1Text: startMin1, endHour1Text: endHour1, endMin1Text: endMin1, startHour2Text: startHour2, startMin2Text: startMin2, endHour2Text: endHour2, endMin2Text: endMin2 )
                
               
                self.courses.append(courses)
                
                self.tableView.reloadData()
                
            }
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    func initialization(){
        for _ in 0...10000{
            
            checked.append(false)
            
        }
       
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //완료버튼 클릭시
    @IBAction func completed(_ sender: Any) {
        
        //SelectedCourses까지 데이터베이스 생성
        let ref = Database.database().reference()
        
        let userReference = ref.child("users")
        
        let uid = Auth.auth().currentUser?.uid
        
        var newUserReference = userReference.child(uid!)
        
        
        newUserReference = newUserReference.child("SelectedCourses")
        
        let count = courses.count-1
        //checked배열 확인하면서 true인 값들 SelectedCourses에 키값으로 추가.
        for i in 0...count {
            let courseCodeForNow = courses[i].courseCode
            
            if self.checked[i] == true{
                
                newUserReference.child(courses[i].courseCode).setValue(["courseName": courses[i].courseName, "courseInstructor": courses[i].courseInstructor, "courseRoom": courses[i].courseRoom, "day1": courses[i].day1, "day2": courses[i].day2, "startHour1": courses[i].startHour1, "startMin1": courses[i].startMin1, "endHour1": courses[i].endHour1, "endMin1": courses[i].endMin1, "startHour2": courses[i].startHour2, "startMin2": courses[i].startMin2, "endHour2": courses[i].endHour2, "endMin2": courses[i].endMin2])
                
            }
            else {
                
                newUserReference.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(courseCodeForNow)
                    {
                        newUserReference.child(courseCodeForNow).removeValue()
                        print("deleted "+courseCodeForNow)
                    }
                    else{
                        print("not found")
                    }
                })
                
                
                
                
            }
            
        }
        //마지막 SelectedCourses값 추가.
        //newUserReference.updateChildValues(["end": 1])
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}






extension TimeTableSelectorViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    
    
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectorCell", for: indexPath)
        cell.isUserInteractionEnabled = true
        
        
        cell.textLabel?.text = courses[indexPath.row].courseName + " " + courses[indexPath.row].courseInstructor
        
        //var index = indexPath.row
        //print(courses[1].courseName)
        
        if !checked[indexPath.row] {
            cell.accessoryType = .none
        } else if checked[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimeTableSelectorViewController.handleSelected(sender:)))
    
        cell.addGestureRecognizer(tapGesture)
        cell.isUserInteractionEnabled = true
        
        
        
        
        /*for num in numberOfselected{
            var i = 0
            if num % 2 == 0 && num != 0{
                selectedCourses[i] = courses[i]
            }
            else {
                selectedCourses.remove(at: i)
            }
            i += 1
            print(numberOfselected[0])
        }*/
        
        
        
        
        
        
        return cell
    }
    
    @objc func handleSelected(sender: UITapGestureRecognizer) {
        print("Tapped")
        //selectedCourses[index] = courses[index]
        let tapLocation = sender.location(in: self.tableView)
        
        //using the tapLocation, we retrieve the corresponding indexPath
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        let index = indexPath![1]
        //finally, we print out the value
        
        if let cell = tableView.cellForRow(at: indexPath!) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                checked[index] = false
            } else {
                cell.accessoryType = .checkmark
                checked[index] = true
            }
        }
        
        
        
        
        
        
        
        
        print(index)
        
        

    }
    
    
    
}

















