//
//  TaskListRow.swift
//  PlantGuide
//
//  Created by (non work) on 17.11.20.
//

import SwiftUI
import AVFoundation

struct TaskListRow: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var finishedTasks = [String()]
    
    var plantID: String
    var plantName: String
    var waterDate: Date
    var isOverdue: Bool?
    
    var body: some View {        
        HStack {
            Button(action: {
                if finishedTasks.contains(where: { $0 == plantID }) {
                    finishedTasks.removeAll { $0 == plantID }
                } else {
                    finishedTasks.append(plantID)
                    
                    simpleSuccess()
                    
                    AudioServicesPlaySystemSound(SystemSoundID(1407))
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    WaterReminderDateHelper.updateWaterReminder(plantID: plantID, waterFactor: 1.0, viewContext: viewContext)
                }
            }, label: {
                Image(systemName: finishedTasks.contains{ $0 == plantID } ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    
            })
            // not so pretty here
            .foregroundColor(finishedTasks.contains{ $0 == plantID } ? isOverdue ?? false ? .red : .blue : Color(.systemGray))
            .frame(width: 25, height: 25)
            
            VStack(alignment: .leading) {
                Text(plantName)
                    .bold()
                                                
                Text("Water Reminder - ")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
                    + Text(" \(DateHelper.getDateString(date: waterDate))")
                    .font(.caption2)
                    .foregroundColor(Color(isOverdue ?? false ? .red : .systemGray))                    
            }.opacity(finishedTasks.contains{ $0 == plantID } ? 0.5 : 1)
            Spacer()
        }
    }
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskListRow(plantID: "qwertz", plantName: "Planty", waterDate: WaterReminderDateHelper.calculateWaterReminder(waterFactor: 3.0, lastWaterDate: nil))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
