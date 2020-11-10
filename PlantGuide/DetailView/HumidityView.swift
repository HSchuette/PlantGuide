//
//  HumidityView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct HumidityView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State private var humidityValue: CGFloat = 0
    @State private var hygroValueMin: CGFloat = 0.5
    @State private var hygroValueMax: CGFloat = 0.5
    
    @Binding var moreInfo: String?
    
    var brightgreen = Color(red: 0.437, green: 0.746, blue: 0.359)
    var yellow = Color("yellow")
    var blue = Color("blue")
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: Color(.systemGray2), image: "cloud.fog.fill")
                    .padding(.trailing, 5)
                
                Text("Humidity")
                    .bold()
                    .padding()
                
                Spacer()
            }
            
            if self.moreInfo == "moreHumidity" {
                VStack(alignment: .leading) {
                    Text("Whether a plant likes moisture in the air or not depends on the native regions. Oftentimes signs of too dry air are when the leafs turn dry and brown. This oftentimes becomes a problem in winter when the heater dries up the air.")
                        .padding(.bottom, 5)
                     .lineLimit(nil)
                     .fixedSize(horizontal: false, vertical: true)
                    
                    Text(selectedPlant.name + "'s need:")
                    
                    HStack {
                        Text(plantData[selectedPlant.id].humidityCategory)
                            .italic()
                        
                        Spacer()
                        
                        BarMeter(width: humidityValue, color: Color(.systemGray2), image: "cloud.fog.fill")
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration:1).delay(0.4)) {
                                    self.humidityValue = 0
                                    self.humidityValue = CGFloat(plantData[selectedPlant.id].humidityFactor)
                                }
                            }
                    }.padding(.bottom)
                    
                    
                    Text("Get to know the status-quo").bold()
                        .padding(.bottom, 5)
                    Text("If humidity never really played a role in your plant care routine, it's best to start with analysing the status quo. The average home humidity level is around 30%. Yet most plants feel comftable at around 50% - 60%.").lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Text("To measure your home humidity simply buy a cheap hygrometer and place it next to your plants. In case your humidity is to low, start misting them with water once or twice a day.").lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(alignment: .top) {
                        Text(selectedPlant.name + " should feel comftable at a humidity of 50-60%.").lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        // hygrometer
                        ZStack {
                            // left circle
                            Circle()
                                .trim(from: 0.5, to: 1.0)
                                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(yellow)
                            
                            // right circle
                            Circle()
                            .trim(from: 0.75, to: 1)
                                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(blue)
                            
                            // background circle
                            Circle()
                                .trim(from: self.hygroValueMin, to: self.hygroValueMax)
                                .stroke(style: StrokeStyle(lineWidth: 22.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color(.systemBackground))
                            
                            // mid circle
                            Circle()
                            .trim(from: self.hygroValueMin, to: self.hygroValueMax)
                                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(brightgreen)
                                
                            
                            Text(plantData[selectedPlant.id].hygroText)
                                .bold()
                                .padding(.top, -10)
                        }.frame(width: 150)
                            .scaleEffect(0.85)
                            .padding(.bottom, -55)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration:1).delay(0.4)){
                                self.hygroValueMin = 0.5
                                self.hygroValueMin = CGFloat(plantData[selectedPlant.id].hygroValueMin)
                                
                                self.hygroValueMax = 0.5
                                self.hygroValueMax = CGFloat(plantData[selectedPlant.id].hygroValueMax)
                                
                            }
                        }
                    }.lineLimit(nil)
                    
                    Text("Tips:")
                        .bold()
                        .padding(.bottom, 5)
                    
                    Group {
                        
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .padding(.leading)
                                .padding(.top, 4)
                                .scaleEffect(0.5)
                            
                            Text("Plants with similar humidity needs should be placed together to create a microenviroment").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .padding(.leading)
                                .padding(.top, 4)
                                .scaleEffect(0.5)
                            
                            Text("Place a shallow plate filled with water and gravel next to the plants, which will create evaporation and increase the relative humidity").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .padding(.leading)
                                .padding(.top, 4)
                                .scaleEffect(0.5)
                            
                            Text("Use a humidifier to increase the humidity.").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .padding(.leading)
                                .padding(.top, 4)
                                .scaleEffect(0.5)
                            
                            Text("Do not use a mist bottle on plants with hairy leafs or flowers. The water will stay longer on these parts, which can lead to disease germination").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }.lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


struct HumidityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HumidityView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            HumidityView(moreInfo: Binding.constant("moreHumidity"))
                .environmentObject(SelectedPlant())
        }
    }
}
