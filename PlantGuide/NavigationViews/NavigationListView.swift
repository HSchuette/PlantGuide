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
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    var body: some View {
        VStack {
            
            if seeAll == true {
            } else {
                TaskList()
            }
            
            if storePlants.isEmpty {
                
                Spacer()
                
                GetStartedButton()
                
            } else {
            
                CardCarousselToppingView(onEdit: $onEdit, seeAll: $seeAll)
                
                
                PlantCardCarousselView(onEdit: $onEdit, seeAll: $seeAll)
                    .padding(.leading, 15)                
            }
        }
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView(onEdit: Binding.constant(true), seeAll: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
