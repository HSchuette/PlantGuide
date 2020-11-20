//
//  TaskListRow.swift
//  PlantGuide
//
//  Created by (non work) on 17.11.20.
//

import SwiftUI

struct TaskListRow: View {
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var plantName: String
    var waterDate: Date
    var isOverdue: Bool?
    
    var body: some View {        
        HStack {
            Button(action: {                
                self.feedback.impactOccurred()
            }, label: {
                Circle()
                    .frame(width: 25, height: 25)
                    
            }).foregroundColor(.red)
            
            VStack(alignment: .leading) {
                Text(plantName)
                    .bold()
                                                
                Text("Water Reminder - ")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
                    + Text(" \(DateHelper.getDateString(date: waterDate))")
                    .font(.caption2)
                    .foregroundColor(Color(isOverdue ?? false ? .red : .systemGray))
            }
        }
    }
}

struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskListRow(plantName: "Planty", waterDate: Date())
    }
}
