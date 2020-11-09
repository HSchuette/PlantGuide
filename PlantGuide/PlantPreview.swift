//
//  PlantPreview.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

struct PlantPreview: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    var plants: Plant
    
    let colorSelected = [Color(.systemBackground),  Color(.systemGray5)]
    let colorUnselected = [Color(.systemBackground),  Color(.systemGray6)]
    
    var body: some View {
        ZStack {
            
            // block
            LinearGradient(gradient: Gradient(colors: selectedPlant.id == plants.id ? colorSelected : colorUnselected), startPoint: .top, endPoint: .bottom)
                .frame(width: 105.0, height: 105.0)
                .foregroundColor(selectedPlant.id == plants.id ? Color(.systemGray5) : Color(.systemBackground))
                .cornerRadius(20)
            
            VStack() {
                
                // image
                Image(plants.imageName)
                    .resizable()
                    .frame(width: 100.0, height: 85.0)
                    .scaledToFit()
                    .padding([.leading,.trailing], 2)
                
                // titles
                Text(plants.name)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, -5)
                    .padding([.leading,.bottom,.trailing], 2)
                
                Spacer()
            }.frame(width: 110, height: 140, alignment: .bottom)
            
        }
        .frame(width: 105, height: 150.0)
        .clipped()
        .scaleEffect(selectedPlant.id == plants.id ? 1.0 : 0.9)
        .clipped()
        .shadow(color: Color(UIColor.black).opacity(selectedPlant.id == plants.id ? 0.2 : 0.05), radius: 4, x: 5, y: 5)
        .shadow(color: Color(.systemGray4).opacity(0.1), radius: 4, x: -5, y: -5)
    }
}

struct PlantPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlantPreview(plants: plantData[0])
                .environmentObject(SelectedPlant())
            PlantPreview(plants: plantData[1])
                .environmentObject(SelectedPlant())
        }
        .previewLayout(.fixed(width: 300, height: 150))
    }
}
