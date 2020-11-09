//
//  CarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 09.11.20.
//

import SwiftUI

struct CarousselView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack() {
                    ForEach(plantData, id: \.id) { plant in
                        PlantPreview(plants: plant)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                        
                                            updateAllValues(id: plant.id)
                                        }
                            }
                    }
                }.padding(.leading)
            }
        }
    }
    func updateAllValues(id: Int) {
        selectedPlant.id = plantData[id].id
        selectedPlant.name = plantData[id].name
    }
}

struct CarousselView_Previews: PreviewProvider {
    static var previews: some View {
        CarousselView()
            .environmentObject(SelectedPlant())
    }
}


