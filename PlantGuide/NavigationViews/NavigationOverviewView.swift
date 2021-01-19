//
//  NavigationOverviewView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationOverviewView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @Binding var showLearnMoreSheet: Bool
    
    var body: some View {
        VStack {
            PlantOverView()
           
            CarousselToppingView(showLearnMoreSheet: $showLearnMoreSheet)
            
            CarousselView()
                .scaleEffect(UIScreen.screenHeight < 600 ? 0.8 : 1.0)
                .padding(UIScreen.screenHeight < 600 ? -20 : 0)
        }
    }
}

struct NavigationOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationOverviewView(showLearnMoreSheet: Binding.constant(false))
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
    }
}
