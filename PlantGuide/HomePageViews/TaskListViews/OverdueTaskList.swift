//
//  OverdueTaskList.swift
//  PlantGuide
//
//  Created by (non work) on 20.11.20.
//

import SwiftUI

struct OverdueTaskList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
         predicate: NSPredicate(format: "(dateNextWatering <= %@)", DateHelper.startOfDay(day: NSDate()), DateHelper.endOfDay(day: NSDate())), animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        if storePlants.isEmpty {
            Spacer()
        } else {
            List {
                Section(header: Text("Overdue")) {
                    ForEach(storePlants) { plant in
                        HStack {
                            Button(action: {
                                self.feedback.impactOccurred()
                            }, label: {
                                Circle()
                                    .frame(width: 25, height: 25)
                            })
                            
                            VStack(alignment: .leading) {
                                Text("\(plant.name!)")
                                    .bold()
                                                                
                                Text("Water Reminder - \(DateHelper.getDateString(date: plant.dateNextWatering!))")
                                    .font(.caption2)
                                    .foregroundColor(Color(.systemGray))
                            }
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
        }
    }
}

struct OverdueTaskList_Previews: PreviewProvider {
    static var previews: some View {
        OverdueTaskList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
