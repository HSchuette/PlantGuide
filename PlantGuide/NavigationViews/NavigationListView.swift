//
//  NavigationListView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct NavigationListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Spacer()
            
            CardCarousselToppingView()
            
            PlantCardCarousselView()
        }
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
