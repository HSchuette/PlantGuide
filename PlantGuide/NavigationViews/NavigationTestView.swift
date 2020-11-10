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
    
    @Binding var showLearnMoreSheet: Bool
    
    var body: some View {
        VStack {
            PlantOverView()
           
            CarousselToppingView(showLearnMoreSheet: $showLearnMoreSheet)
            
            CarousselView()
        }
    }
}

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView(showLearnMoreSheet: Binding.constant(false))
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
    }
}
