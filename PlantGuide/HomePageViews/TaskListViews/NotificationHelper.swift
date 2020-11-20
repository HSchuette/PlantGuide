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
    static func addNotification(for plant: StorePlantEntity, setDay: Int?, setWeekday: Int?, setHour: Int, setMinute: Int, isRepeat: Bool) {
        
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "🌱 Water Reminder"
            content.body = "Check on \(plant.name!) and remember to only water \(plant.waterCategory!)."
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.day = setDay
            dateComponents.weekday = setWeekday
            dateComponents.hour = setHour
            dateComponents.minute = setMinute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
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
    
    static func setNotification(plant: StorePlantEntity, waterFactor: Double) {
        if 0.0 ... 2.0 ~= waterFactor {
            addNotification(for: plant, setDay: nil, setWeekday: 6, setHour: 10, setMinute: 0, isRepeat: true)
        } else if 2.1 ... 9.9 ~= waterFactor {
            addNotification(for: plant, setDay: nil, setWeekday: 2, setHour: 10, setMinute: 0, isRepeat: true)
            addNotification(for: plant, setDay: nil, setWeekday: 6, setHour: 10, setMinute: 0, isRepeat: true)
        }
    }
}

