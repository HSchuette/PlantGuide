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
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        List {
            ForEach(storePlants) { plant in
                HStack {
                    Button(action: {
                        NotificationHelper.addNotification(for: plant, setDay: 2, setWeekday: 5, setHour: 7, setMinute: 24, isRepeat: true)
                        self.feedback.impactOccurred()
                    }, label: {
                        Circle()
                            .frame(width: 25, height: 25)
                    })
                    
                    VStack(alignment: .leading) {
                        Text(plant.name!)
                            .bold()
                        
                        Text("Check on your plant if it needs water")
                            .font(.caption2)
                            .foregroundColor(Color(.systemGray))
                    }
                }
            }
        }.listStyle(GroupedListStyle())
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
