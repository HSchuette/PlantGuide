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
             predicate: NSPredicate(format: "(dateNextWatering <= %@)", DateHelper.endOfDay(day: NSDate())), animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack {
            Section(header: ListHeader(text: "TODAY", imageName: storePlants.isEmpty ? "calendar" : "calendar.badge.exclamationmark")) {
                if storePlants.isEmpty {
                    VStack {
                        HStack {
                            
                            Text("All Done!")
                            
                            Image(systemName: "hands.clap.fill")
                                                    
                        }.opacity(0.5)
                    }
                    
                } else {
                
                    ForEach(storePlants) { plant in
                        TaskListRow(plantID: plant.id!, plantName: plant.name!, waterDate: plant.dateNextWatering!, isOverdue: plant.dateNextWatering! <= DateHelper.startOfDay(day: NSDate()) as Date ? true : false)
                    }
                }
            }
            Spacer()
        }
    }
}


struct TodayTaskList_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



