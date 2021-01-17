//
//  WaterView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct WaterView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State private var waterValue: CGFloat = 0
    
    @Binding var moreInfo: String?

    var blue = Color("blue")
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                    CircleIcon(color: blue, image: "cloud.rain.fill")
                        .padding(.trailing, 5)

                Text("Water")
                    .bold()
                    .padding()
                
                Spacer()
            }

            if self.moreInfo == "moreWater" {
                VStack(alignment: .leading) {
                    Text("Like all living things, plants need water to survive. But many people are not sure about how much water their plant need and if the water that comes out of the tap is good enough. Generally, the lukewarm tap water is sufficient for mosts plants.")
                        .padding(.bottom, 5)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("The most important thing about watering your plants is understanding when to water it.")
                        .padding(.bottom)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Text(selectedPlant.name + "'s need:")
                    
                    HStack {
                        Text(plantData[selectedPlant.id].waterCategory)
                            .italic()
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        BarMeter(width: self.waterValue, color: blue, image: "cloud.rain.fill", isWide: false)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration:1).delay(0.4)) {
                                    self.waterValue = 0
                                    self.waterValue = CGFloat(plantData[selectedPlant.id].waterFactor)
                                }
                            }
                        
                    }.padding(.bottom)
                    
                    
                    Text("Water Routine").bold()
                            .padding(.bottom, 5)
                        Text("One of the most common mistakes is to stick to a watering schedule. This usually results in overwatering. It's best to check your plants regularly and test the soil a few centimeters below the surface before watering. If you are in doubt, wait a day more before watering your plant.")
                            .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }.lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaterView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            WaterView(moreInfo: Binding.constant("moreWater"))
                .environmentObject(SelectedPlant())
        }
    }
}
