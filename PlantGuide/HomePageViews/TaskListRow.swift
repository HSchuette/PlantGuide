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
    
    var body: some View {
        HStack {
            Button(action: {
                self.feedback.impactOccurred()
            }, label: {
                Circle()
                    .frame(width: 25, height: 25)
            })
            
            VStack(alignment: .leading) {
                Text(plantName)
                    .bold()
                
                Text("Check on your plant if it needs water")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskListRow(plantName: "Planty")
    }
}
