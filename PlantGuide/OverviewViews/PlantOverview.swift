//
//  PlantOverview.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

struct PlantOverView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
        
    var body: some View {
        VStack {
            
            HStack {
                // big name title
                Text(selectedPlant.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.leading, 25)
                    .animation(nil)
                
                
                Spacer()
            }.padding(.top)
            
            HStack {
                
                // small latin undertitle
                
                Text( "latin: " + selectedPlant.latin)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(Color(.systemGray))
                    .padding(.leading, 25)
                    .padding(.top, 5)
                    .animation(nil)
                
                Spacer()
            }.padding(.bottom)
            
            Spacer()
            
            
            // Graphs and Bar Charts
            HStack{
                BarGraphs()
            }
            
           
            Spacer()
            
            if UIScreen.screenWidth > 400 {
                VStack(alignment: .leading) {
                    HStack {
                        Text(selectedPlant.description).font(.caption)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }.padding(.horizontal, 40)
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .animation(nil)
            }
            
            
            
        }
    }
}

struct PlantOverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlantOverView()
                .environmentObject(SelectedPlant())
        }.previewLayout(.fixed(width: 400, height: 550))
    }
}
