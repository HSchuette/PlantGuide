//
//  WaterReminderHelper.swift
//  PlantGuide
//
//  Created by (non work) on 21.11.20.
//

import Foundation
import CoreData

struct WaterReminderDateHelper {
    
    static func calculateWaterReminder(waterFactor: Double, lastWaterDate: Date?) -> Date {
        
        var nextOccurrence = Date()
        
        if 0.0 ... 2.0 ~= waterFactor {
            let lastDate = lastWaterDate ?? Date()
            let calendar = Calendar.current
            let components = DateComponents(weekday: 2)
            nextOccurrence = calendar.nextDate(after: lastDate, matching: components, matchingPolicy: .nextTime)!
            
        } else {
            let lastDate = lastWaterDate ?? Date()
            let calendar = Calendar.current
            let currentWeekday = calendar.component(.weekday, from: lastDate)
            let nextWeekdays = 3...4 ~= currentWeekday ? [6, 2] : [2, 6]
            
            _ = nextWeekdays.map { weekday -> Date in
                let components = DateComponents(weekday: weekday)
                nextOccurrence = calendar.nextDate(after: lastDate, matching: components, matchingPolicy: .nextTime)!
                
                return nextOccurrence
            }
        }
        
        return nextOccurrence
        
    }
    
    static func updateWaterReminder(plantID: String, waterFactor: Double, viewContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StorePlantEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", plantID)
        fetchRequest.fetchLimit = 1
        
        var nextWaterDate = Date()
        
        nextWaterDate = calculateWaterReminder(waterFactor: waterFactor, lastWaterDate: nil)
        
        do {
            let updateContext = try viewContext.fetch(fetchRequest)
            let dateUpdate = updateContext[0] as! NSManagedObject
            dateUpdate.setValue(nextWaterDate, forKey: "dateNextWatering")
        } catch {
            print(error)
        }
    }
}
