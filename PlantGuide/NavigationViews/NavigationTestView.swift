//
//  NavigationTestView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationTestView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    var body: some View {
        VStack {
            PlantOverView(selected: Binding.constant(0),  lightMeter: Binding.constant(0), waterMeter: Binding.constant(0), humidityMeter: Binding.constant(0))
           
            ScrollView(.horizontal, showsIndicators: true) {
                HStack() {
                    ForEach(plantData, id: \.id) { plant in
                        PlantPreview(plants: plant, selected: Binding.constant(nil))
                    }
                }
            }
        }
    }
}

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
    }
}
