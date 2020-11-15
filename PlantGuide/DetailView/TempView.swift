//
//  TempView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct TempView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State private var tempValue: CGFloat = 0
    
    @Binding var moreInfo: String?
    
    var red = Color(red: 143/256, green: 43/256, blue: 45/256)
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: red, image: "thermometer")
                    .padding(.trailing, 5)
                
                Text("Temperature")
                    .bold()
                    .padding()
            
                Spacer()
            }
            
            if self.moreInfo == "moreTemp" {
                VStack(alignment: .leading) {
                    Text("Room temperature oftentimes refers to 20 to 25 degrees Celcius. Usually these temperatures are sufficient for plants that originate from tropical or subtropical areas of the world. They oftentime tolerate temperatures ranging from 15 to 30 degrees.")
                        .padding(.bottom, 5)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Though not all interior plants have the same temperature requirements for optimal growth.")
                        .padding(.bottom, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Text(selectedPlant.name + "'s need:")
                    
                    HStack {
                        Text(plantData[selectedPlant.id].tempCategory)
                            .italic()
                        
                        Spacer()
                        
                        BarMeter(width: self.tempValue, color: red, image: "thermometer", isWide: false)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration:1).delay(0.4)) {
                                    self.tempValue = 0
                                    self.tempValue = CGFloat(plantData[selectedPlant.id].tempFactor)
                                }
                            }
                    }.padding(.bottom)
                }.lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TempView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            TempView(moreInfo: Binding.constant("moreTemp"))
                .environmentObject(SelectedPlant())
        }
    }
}
