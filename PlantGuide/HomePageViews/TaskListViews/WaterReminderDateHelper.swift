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
        let lastDate = lastWaterDate ?? Date()
        
        if 0.0 ... 2.0 ~= waterFactor {
            nextOccurrence = Calendar.current.date(byAdding: .day, value: 5, to: lastDate)!
        } else {
            nextOccurrence = Calendar.current.date(byAdding: .day, value: 3, to: lastDate)!
        }
        
        return nextOccurrence
        
    }
    
    static func updateWaterReminder(plantID: String, waterFactor: Double, viewContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StorePlantEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", plantID)
        fetchRequest.fetchLimit = 1
        
        var nextWaterDate = Date()
        
        nextWaterDate = calculateWaterReminder(waterFactor: waterFactor, lastWaterDate: nil)
        print("\(nextWaterDate)")
        
        do {
            let updateContext = try viewContext.fetch(fetchRequest)
            let dateUpdate = updateContext[0] as! NSManagedObject
            dateUpdate.setValue(nextWaterDate, forKey: "dateNextWatering")
            
            NotificationHelper.setNotification(plant: dateUpdate as! StorePlantEntity, waterFactor: waterFactor, lastWaterDate: dateUpdate.value(forKey: "dateLastWatering") as? Date)
        } catch {
            print(error)
        }
    }
}
