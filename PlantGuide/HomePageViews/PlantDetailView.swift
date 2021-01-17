//
//  PlantDetailView.swift
//  PlantGuide
//
//  Created by (non work) on 08.12.20.
//

import SwiftUI

struct PlantDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var plant: StorePlantEntity
    
    
    var body: some View {
        Text("\(plant.name ?? "PlaceHolder")")
    }
}

struct PlantDetailView_Previews: PreviewProvider {
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    static var storePlants: FetchedResults<StorePlantEntity>
    
    static var previews: some View {
        PlantDetailView(plant: storePlants[1])
    }
}
