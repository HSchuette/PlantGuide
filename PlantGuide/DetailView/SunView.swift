//
//  SunView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct SunView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State private var sunValue: CGFloat = 0
    @State private var compassValueStart: CGFloat = 0
    @State private var compassValueEnd: CGFloat = 0
    
    @Binding var moreInfo: String?
    
    var yellow = Color("yellow")
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: yellow, image: "sun.max.fill")
                
                Text("Sunlight")
                    .bold()
                    .padding()
                
                Spacer()
            }
            
            if self.moreInfo == "moreSun" {
                VStack(alignment: .leading) {
                    Text("Food and water are an essential foundation of all living creatures. For plants, the food is being produced by a cycle known as photosynthesis, in which chloroplasts absorb the energy of light, causing several metabolic reactions — one of these being the production of plant sugars, food.")
                        .padding(.bottom)
                    
                    Text(selectedPlant.name + "'s need:")
                    
                    HStack {
                        Text(plantData[selectedPlant.id].lightCategory.rawValue)
                            .italic()
                        
                        Spacer()
                        
                        BarMeter(width: self.sunValue, color: yellow, image: "sun.max.fill")
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration:1).delay(0.4)) {
                                    self.sunValue = 0
                                    self.sunValue = CGFloat(plantData[selectedPlant.id].lightFactor)
                                }
                            }
                        
                    }.padding(.bottom)
                    
                    Text("Window direction").bold()
                        .padding(.bottom, 5)
                    Text("The right lighting condition plays a great role in the health and growth of your plants. Usually it's best to place your plants next to a window. Though, not all window directions will grant you enough light.").lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(alignment: .top) {
                        
                        Text("The orientation of the window can generaly give you an indication whether the required light conditions are enough.").lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        // compass
                        ZStack {
                            Image("compass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                            
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 15.0)
                                    .opacity(0.3)
                                    .foregroundColor(yellow)
                                
                                Circle()
                                    .trim(from: compassValueStart, to: compassValueEnd)
                                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                                    .foregroundColor(yellow)
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration:2).delay(0.4)){
                                            self.compassValueStart = 0
                                            self.compassValueEnd = 0
                                            
                                            self.compassValueStart = CGFloat(plantData[selectedPlant.id].compassValueStart)
                                            self.compassValueEnd = CGFloat(plantData[selectedPlant.id].compassValueEnd)
                                        }
                                    }
                                    .rotationEffect(Angle(degrees: 45))
                                
                                if plantData[selectedPlant.id].compassTwoValues {
                                    Circle()
                                        .trim(from: compassValueStart, to: compassValueEnd)
                                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                                    .foregroundColor(yellow)
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration:2).delay(0.4)){
                                            self.compassValueStart = 0
                                            self.compassValueEnd = 0
                                            
                                            self.compassValueStart = CGFloat(plantData[selectedPlant.id].compassValueStart)
                                            self.compassValueEnd = CGFloat(plantData[selectedPlant.id].compassValueEnd)
                                        }
                                    }
                                    .rotationEffect(Angle(degrees: 225))
                                }
                                
                                
                            }.frame(width: 125, height: 125)
                                .scaleEffect(0.9)
                        }
                    }
                }.lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SunView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            SunView(moreInfo: Binding.constant("moreSun"))
                .environmentObject(SelectedPlant())
        }
    }
}
