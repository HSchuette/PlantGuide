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
    static func addNotification(for plant: StorePlantEntity) {
        
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "🌱 Water Reminder"
            content.body = "Check on \(plant.name!) and remember to only water \(plant.waterCategory!)."
            content.sound = UNNotificationSound.default

    //        var dateComponents = DateComponents()
    //        dateComponents.hour = 9
    //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

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
}
