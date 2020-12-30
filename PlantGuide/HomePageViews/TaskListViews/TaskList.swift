//
//  TaskList.swift
//  PlantGuide
//
//  Created by (non work) on 20.11.20.
//

import SwiftUI

struct TaskList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @StateObject var storeManager: StoreManager
    
    @Binding var showUpgradeView: Bool
    var isPremium = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Reminders")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // correct this statement later
                if storePlants.count >= 3 || !isPremium {
                    Button(action: {
                        print("buy botton clicked")
                        showUpgradeView.toggle()
                        
                    }, label: {
                        HStack {
                            Text("Upgrade")
                                .font(.subheadline)
                            
                            Image(systemName: "sparkles")
                                .font(.subheadline)
                        }
                        
                    })
                }
            }.sheet(isPresented: $showUpgradeView, content: {
                UpgradeView(storeManager: storeManager)
            })
            
            Divider()
            
            ScrollView(.vertical) {
                TodayTaskList()
            }
                
        }.padding(.horizontal, 25)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(storeManager: StoreManager(), showUpgradeView: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
