//
//  Courses.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 15..
//  Copyright © 2017년 suh. All rights reserved.
//

import Foundation
class Courses {
    var courseName: String
    var courseRoom: String
    var courseInstructor: String
    var courseCode: String
    var weekday: TimeTableWeekday?
    var day1: Int
    var day2: Int
    var startHour1: Int
    var startMin1: Int
    var endHour1: Int
    var endMin1: Int
    var startHour2: Int
    var startMin2: Int
    var endHour2: Int
    var endMin2: Int
    
    
    
    init(courseCodeText:String, courseText: String, courseRoomText: String, courseInstructorText: String, day1Text: Int, day2Text: Int,
         startHour1Text: Int, startMin1Text: Int, endHour1Text: Int, endMin1Text: Int, startHour2Text: Int, startMin2Text: Int, endHour2Text: Int, endMin2Text: Int ) {
        courseName = courseText
        courseRoom = courseRoomText
        courseInstructor = courseInstructorText
        courseCode = courseCodeText
        day1 = day1Text
        day2 = day2Text
        startHour1 = startHour1Text
        startMin1 = startMin1Text
        endHour1 = endHour1Text
        endMin1 = endMin1Text
        startHour2 = startHour2Text
        startMin2 = startMin2Text
        endHour2 = endHour2Text
        endMin2 = endMin2Text
        
    }
    
    
   
}


