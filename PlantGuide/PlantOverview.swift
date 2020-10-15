//
//  PlantOverview.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

struct PlantOverView: View {
    
    @Binding var selected: Int?
    @Binding var lightMeter: Int?
    @Binding var waterMeter: Double?
    @Binding var humidityMeter: Int?
        
    var body: some View {
        VStack {
            
            HStack {
                // big name title
                Text(selected == nil ? "" : plantData[selected!].name)
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.leading, 25)
                    .animation(nil)
                
                
                Spacer()
            }.padding(.top)
            
            HStack {
                
                // small latin undertitle
                
                Text(selected == nil ? "" : "latin: " + plantData[selected!].latin)
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
                BarGraphs(selected: $selected, lightMeter: $lightMeter, waterMeter: $waterMeter, humidityMeter: $humidityMeter)
            }
            
           
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(selected == nil ? "" : plantData[selected!].description).font(.footnote)
                    
                    Spacer()
                }
                
                Spacer()
            }.padding(.horizontal, 40)
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .animation(nil)
            
            
            
        }
    }
}

struct PlantOverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlantOverView(selected: Binding.constant(0), lightMeter: Binding.constant(3), waterMeter: Binding.constant(2), humidityMeter: Binding.constant(3))
            PlantOverView(selected: Binding.constant(1), lightMeter: Binding.constant(4), waterMeter: Binding.constant(2), humidityMeter: Binding.constant(3))
            PlantOverView(selected: Binding.constant(nil), lightMeter: Binding.constant(nil), waterMeter: Binding.constant(nil), humidityMeter: Binding.constant(nil))
        }.previewLayout(.fixed(width: 400, height: 550))
    }
}
