//
//  NotificationHelper.swift
//  PlantGuide
//
//  Created by (non work) on 19.11.20.
//

import Foundation
import UserNotifications

//func getNextWaterDay(lastWatering: Date, waterNeedFactor: Double) {
//
////    if waterNeedFactor == 3 {
////    }
//
//}

struct NotificationHelper {
    static func addNotification(for plant: StorePlantEntity, nextWaterDate: Date?, setHour: Int, setMinute: Int) {
        
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "🌱 Water Reminder"
            content.body = "Check on \(plant.name!) and remember to only water \(plant.waterCategory!)."
            content.sound = UNNotificationSound.default

            let nextWaterDate = nextWaterDate ?? Date(timeIntervalSinceNow: 60 * 60 * 24 * 3)
            let notificationDate = Calendar.current.date(bySettingHour: setHour, minute: setMinute, second: 0, of: nextWaterDate)!
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

//            var dateComponents = DateComponents()
//            dateComponents.day = setDay
//            dateComponents.weekday = setWeekday
//            dateComponents.hour = setHour
//            dateComponents.minute = setMinute
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: plant.id!, content: content, trigger: trigger)
            center.add(request)
            print("Notification added for \(triggerDate)")
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                if plant.isWaterReminder == true {
                    addRequest()
                }
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("No authorization for notifications")
                    }
                }
            }
        }
    }
    
    static func setNotification(plant: StorePlantEntity, waterFactor: Double, lastWaterDate: Date?) {
        let nextWaterDate = WaterReminderDateHelper.calculateWaterReminder(waterFactor: waterFactor, lastWaterDate: lastWaterDate)
    
        try? cancelNotification(plant: plant)

        addNotification(for: plant, nextWaterDate: nextWaterDate, setHour: 10, setMinute: 0)
        
        print("\(nextWaterDate)")
        
        getAllNotifications()
    }
    
    static func cancelNotification(plant: StorePlantEntity) {
        let id = plant.id!
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.removeDeliveredNotifications(withIdentifiers: [id])
        
        print("Deleted notification for \(plant.name!), id = \(plant.id!)")
        
        getAllNotifications()
    }
    
    static func getAllNotifications() {
        let center = UNUserNotificationCenter.current()
        
        center.getPendingNotificationRequests(completionHandler: { requests in
            print("\(requests.count)")
            
        })
    }
}


