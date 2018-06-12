

import Foundation
import UIKit

public enum TimeTableWeekday: Int {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6
}

public struct TimeTableItem {
    
    public var name: String //Subject
    public var place: String //Place
    
    
    public var professor: String // professor : 교수
    public var startClass: Int // startclass : 시작시간
    public var endClass: Int // endClass : 끝나는 시간
    
    public var weekday: TimeTableWeekday
    public var startPoint: Int
    public var endPoint: Int
    public var startMinutes: Int
    public var endMinutes: Int
    public var textColor: UIColor
    public var bgColor: UIColor
    
    public init(name: String, place: String, professor: String, startClass: Int, endClass: Int, weekday: TimeTableWeekday, startPoint: Int, endPoint: Int, startMinutes: Int, endMinutes:Int, textColor: UIColor, bgColor: UIColor) {
        self.name = name
        self.place = place
        self.professor = professor
        self.startClass = startClass
        self.endClass = endClass
        self.weekday = weekday
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.startMinutes = startMinutes
        self.endMinutes = endMinutes
        self.textColor = textColor
        self.bgColor = bgColor
    }
}

