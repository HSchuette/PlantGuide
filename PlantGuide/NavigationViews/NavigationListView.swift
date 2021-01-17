//
//  NavigationListView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct NavigationListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var onEdit: Bool
    @Binding var seeAll: Bool
    @Binding var showUpgradeView: Bool
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        VStack {
            
            if seeAll == true {
            } else {
                TaskList(storeManager: storeManager, showUpgradeView: $showUpgradeView)
            }
            
            if storePlants.isEmpty {
                
                Spacer()
                
                GetStartedButton()
                
            } else {
            
                CardCarousselToppingView(storeManager: storeManager, onEdit: $onEdit, seeAll: $seeAll, showUpgradeView: $showUpgradeView)
                
                PlantCardCarousselView(onEdit: $onEdit, seeAll: $seeAll)                                 
            }
        }.padding(.top, 25)
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView(onEdit: Binding.constant(true), seeAll: Binding.constant(true), showUpgradeView: Binding.constant(false),storeManager: StoreManager())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
