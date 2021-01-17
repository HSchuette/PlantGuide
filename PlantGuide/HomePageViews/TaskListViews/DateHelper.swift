//
//  DateHelper.swift
//  PlantGuide
//
//  Created by (non work) on 20.11.20.
//

import Foundation

// this part calculates the start and the end of the day
class DateHelper{
    internal class func startOfDay(day: NSDate) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
        var todayComponents = gregorian!.components(unitFlags, from: day as Date)
        todayComponents.hour = 0
        todayComponents.minute = 0
        return (gregorian?.date(from: todayComponents))! as NSDate
    }

    internal class func endOfDay(day: NSDate) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
        var todayComponents = gregorian!.components(unitFlags, from: day as Date)
        todayComponents.hour = 23
        todayComponents.minute = 59
        return (gregorian?.date(from: todayComponents))! as NSDate
    }
    
    internal class func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}
