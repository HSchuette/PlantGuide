//
//  PlantCardCarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI

struct PlantCardCarousselView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(storePlants) { plant in
                    CardView(plantName: plant.name!, plantType: plant.type!, plantID: plant.id!)
                        .padding(5)
                }
            }
            .padding(15)            
        }
        
    }
}

struct PlantCardCarousselView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCardCarousselView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
