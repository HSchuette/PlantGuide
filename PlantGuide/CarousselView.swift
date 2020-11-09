//
//  CarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 09.11.20.
//

import SwiftUI

struct CarousselView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    // i have to make this work with the enviromentobject
    // probably change the cases to Int if possible
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CarousselView_Previews: PreviewProvider {
    static var previews: some View {
        CarousselView()
            .environmentObject(SelectedPlant())
    }
}
