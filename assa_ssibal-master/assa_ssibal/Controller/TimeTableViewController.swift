

import UIKit
import Firebase


class TimeTableViewController: UIViewController {
    @IBOutlet weak var timeTableView: TimeTableView!
    
    @IBAction func reload(_ sender: Any) {
        
        
    }
    var selectedCourses = [Courses]()
    var itemsToPut = [TimeTableItem]()
    
    
    let ad = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        loadCourses()
        print(1)
        print(Auth.auth().currentUser?.uid as Any)
        
        //showTimeTable()
        
        
        
        /*let item1 = TimeTableItem(name: "유닉스조교", place: "E동423호", professor: "전광일", startClass: 3, endClass: 5, weekday: .monday, startPoint: 15, endPoint: 17, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0))
        let item2 = TimeTableItem(name: "유닉스조교", place: "E동423호", professor: "전광일", startClass: 5, endClass: 10, weekday: .wednesday, startPoint: 15, endPoint: 17, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0))
        let item3 = TimeTableItem(name: "엔터프라이즈 컴퓨팅", place: "E동422호", professor: "허훈식", startClass: 3, endClass: 7, weekday: .thursday, startPoint: 11, endPoint: 12, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 0.0, green: 0.83, blue: 0.62, alpha: 1.0))
        let item4 = TimeTableItem(name: "수치해석", place: "E동422호", professor: "전영민", startClass: 3, endClass: 6, weekday: .thursday, startPoint: 14, endPoint: 17, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 0.78, green: 0.49, blue: 0.87, alpha: 1.0))
        let item5 = TimeTableItem(name: "인관관계의 심리학", place: "B동401호", professor: "아아아", startClass: 1, endClass: 6, weekday: .friday, startPoint: 14, endPoint: 17, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.52, blue: 0.11, alpha: 1.0))
        let item6 = TimeTableItem(name: "종합설계", place: "E동423호", professor: "전광일", startClass: 5, endClass: 10, weekday: .thursday, startPoint: 17, endPoint: 22, startMinutes: 30, endMinutes:00, textColor: UIColor.white, bgColor: UIColor(red: 0.46, green: 0.82, blue: 0.0, alpha: 1.0))
        
        let item7 = TimeTableItem(name: "아침운동", place: "호수공원", professor: "송종훈", startClass: 10, endClass: 20, weekday: .sunday, startPoint: 9, endPoint: 10, startMinutes: 00, endMinutes:30, textColor: UIColor.white, bgColor: UIColor(red: 0.96, green: 0.38, blue: 0.76, alpha: 1.0))
        let item8 = TimeTableItem(name: "저녁운동", place: "호수공원", professor: "송종훈", startClass: 4, endClass: 20, weekday: .sunday, startPoint: 20, endPoint: 21, startMinutes: 0, endMinutes:0, textColor: UIColor.white, bgColor: UIColor(red: 0.0, green: 0.69, blue: 0.95, alpha: 1.0))
             
        timeTableView.items.append(item1)
        timeTableView.items.append(item2)
        timeTableView.items.append(item6)
        timeTableView.items.append(item3)
        timeTableView.items.append(item4)
        timeTableView.items.append(item7)
        timeTableView.items.append(item5)
        timeTableView.items.append(item8)
        
        */
        
        
        /*for i in 0...count{
        
            let name = selectedCourses[i].courseName
            let professor = selectedCourses[i].courseInstructor
            let place = selectedCourses[i].courseRoom
            
            
            
            let item1 = TimeTableItem(name: name, place: place, professor: professor, startClass: 3, endClass: 5, weekday: .monday, startPoint: 15, endPoint: 17, startMinutes: 30, endMinutes:20, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0))
            
            timeTableView.items.append(item1)
         }
        }*/
        
        
        
        
    }
    
    
        
        
    
    
    
    
    
    
    
    
    func loadCourses() {
        
        
            self.timeTableView.reloadData()
            self.timeTableView.reDrawAllItems()
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("SelectedCourses").observe(.childAdded) { (snapshot : DataSnapshot) in
            print(snapshot.childrenCount)
            if let dict = snapshot.value as? [String: Any]{
                
                let courseName = dict["courseName"] as! String
                let courseRoom = dict["courseRoom"] as! String
                let courseInstructor = dict["courseInstructor"] as! String
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
                let courseCode = snapshot.ref.key
                print(courseName, courseRoom)
                
                let courses = Courses(courseCodeText: courseCode, courseText: courseName, courseRoomText: courseRoom, courseInstructorText: courseInstructor, day1Text: day1, day2Text: day2, startHour1Text: startHour1, startMin1Text: startMin1, endHour1Text: endHour1, endMin1Text: endMin1, startHour2Text: startHour2, startMin2Text: startMin2, endHour2Text: endHour2, endMin2Text: endMin2 )
                print(courses.courseName)
                
                
                self.selectedCourses.append(courses)
                
                
                
                
                
                print(self.selectedCourses[0].courseRoom)
                //self.selectedCourses.
                self.timeTableView.reloadData()
            }
            
            let count = self.selectedCourses.count
            
            
            
            for i in 0...count-1{
            
                let courseName = self.selectedCourses[i].courseName
                let courseRoom = self.selectedCourses[i].courseRoom
                let courseInstructor = self.selectedCourses[i].courseInstructor
            
                let tempItem1 = TimeTableItem(name: courseName, place: courseRoom, professor: courseInstructor, startClass: 3, endClass: 5, weekday: TimeTableWeekday(rawValue: self.selectedCourses[i].day1)!, startPoint: self.selectedCourses[i].startHour1, endPoint: self.selectedCourses[i].endHour1, startMinutes: self.selectedCourses[i].startMin1, endMinutes: self.selectedCourses[i].endMin1, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0))
                let tempItem2 = TimeTableItem(name: courseName, place: courseRoom, professor: courseInstructor, startClass: 3, endClass: 5, weekday: TimeTableWeekday(rawValue: self.selectedCourses[i].day2)!, startPoint: self.selectedCourses[i].startHour2, endPoint: self.selectedCourses[i].endHour2, startMinutes: self.selectedCourses[i].startMin2, endMinutes: self.selectedCourses[i].endMin2, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0))
                self.timeTableView.drawItem(item: tempItem1)
                self.timeTableView.drawItem(item: tempItem2)
                
                
                
                
            
            }
            
            
            
            
            
        }
        
    }
    
    
    
    
    
   
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension TimeTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (timeTableView.numberOfPeriods + 1)  *  (timeTableView.numberOfDays + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeTableCell", for: indexPath) as! TimeTableViewCell
        
        cell.backgroundColor = timeTableView.symbolsBgColor
        cell.layer.borderWidth = timeTableView.borderWidth
        cell.layer.borderColor = timeTableView.borderColor.cgColor
        
        for subView in cell.subviews { //셀에 그려진 텍스트 정리하기.
            subView.removeFromSuperview()
        }
        
        if indexPath.row == 0 {
            //빈칸
        }
        else if indexPath.row < (timeTableView.numberOfDays + 1) { //요일을 나타내기
            let label: UILabel = UILabel()
            label.font = UIFont.systemFont(ofSize: timeTableView.symbolsFontSize)
            label.text = ad.weekdaySymbols[indexPath.row - 1]
            label.frame = cell.bounds
            label.textAlignment = .center
            cell.addSubview(label)
        } else if indexPath.row % (timeTableView.numberOfDays + 1) == 0 { //시간을 나타내기
            let label: UILabel = UILabel()
            label.font = UIFont.systemFont(ofSize: timeTableView.symbolsFontSize)
            label.text = String(ad.today[timeTableView.startPoint + (indexPath.row / (timeTableView.numberOfDays + 1)) - 1])
            label.sizeToFit()
            let rect:CGRect = CGRect(origin: label.bounds.origin, size: CGSize(width: cell.frame.width, height: label.bounds.height))
            label.frame = rect
            label.textAlignment = .right
            cell.addSubview(label)
        } else { //나머지
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: timeTableView.widthOfPeriodSymbols-0.1, height: timeTableView.heightOfWeekdaySymbols)
        } else if indexPath.row < (timeTableView.numberOfDays + 1) {
            return CGSize(width: timeTableView.averageWidth-0.1, height: timeTableView.heightOfWeekdaySymbols)
        } else if indexPath.row % (timeTableView.numberOfDays + 1) == 0 {
            return CGSize(width: timeTableView.widthOfPeriodSymbols-0.1, height: timeTableView.averageHeight)
        } else {
            return CGSize(width: timeTableView.averageWidth-0.1, height: timeTableView.averageHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

























