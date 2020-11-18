//
//  TaskList.swift
//  PlantGuide
//
//  Created by (non work) on 17.11.20.
//

import SwiftUI

struct TaskList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        predicate: NSPredicate(format: "(dateNextWatering => %@) AND (dateNextWatering <= %@)", DateHelper.startOfDay(day: NSDate()), DateHelper.endOfDay(day: NSDate())), animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    var body: some View {
        List {
            ForEach(storePlants) { plant in
                VStack(alignment: .leading) {
                    TaskListRow(plantName: plant.name!)
                }
            }
        }.listStyle(DefaultListStyle())
        .padding()
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


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
}
