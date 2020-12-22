//
//  TaskList.swift
//  PlantGuide
//
//  Created by (non work) on 20.11.20.
//

import SwiftUI

struct TaskList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Reminders")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
            }
            
            Divider()
            
            ScrollView(.vertical) {
                TodayTaskList()
            }
                
        }.padding(.horizontal, 25)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
