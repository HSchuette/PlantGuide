//
//  TodayTaskList.swift
//  PlantGuide
//
//  Created by (non work) on 17.11.20.
//

import SwiftUI

struct TodayTaskList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
             entity: StorePlantEntity.entity(),
             sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
             predicate: NSPredicate(format: "(dateNextWatering => %@) AND (dateNextWatering <= %@)", DateHelper.startOfDay(day: NSDate()), DateHelper.endOfDay(day: NSDate())), animation: .default)
    

    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        List {
            Section(header: Text("Today")) {
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
            }
        }.listStyle(GroupedListStyle())
    }
}


struct TodayTaskList_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


