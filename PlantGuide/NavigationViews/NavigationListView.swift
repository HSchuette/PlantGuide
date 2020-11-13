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
    
    var body: some View {
        VStack {
            
            Spacer()
            
            CardCarousselToppingView()
            
            PlantCardCarousselView(onEdit: $onEdit)
        }
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView(onEdit: Binding.constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
