//
//  FertilizationView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct FertilizationView: View {

    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State private var fertilizationValue: CGFloat = 0
    
    @Binding var moreInfo: String?
    
    var green = Color(red: 0.267, green: 0.451, blue: 0.216)
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: green, image: "leaf.arrow.circlepath")
                    .padding(.trailing, 5)
                
                Text("Fertilization")
                    .bold()
                    .padding()
                
                
                Spacer()
            }
            
            if self.moreInfo == "moreFertilization" {
                VStack(alignment: .leading) {
                    Text("Houseplants get their nutrients directly out of the soil. Because plants use the nutrients to grow, the saturation decreases over time. Fertilizers can be used to keep the level steady and your plants healthy.")
                        .padding(.bottom, 5)
                    
                    Text("Every plant has slightly different needs when it comes to minerals inside the soil. But there is no need to overcomplicate things. Usually rencently potted plants and low light plants don't up use that much nutrients and thus don't need to much fertilization. It's also best to only fertilize in summer.")
                        .padding(.bottom, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Text(selectedPlant.name + "'s need:")
                    
                    HStack {
                        Text(plantData[selectedPlant.id].fertilizationCategory)
                            .italic()
                        
                        Spacer()
                        
                        BarMeter(width: self.fertilizationValue, color: green, image: "leaf.arrow.circlepath", isWide: false)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration:1).delay(0.4)) {
                                    self.fertilizationValue = 0
                                    self.fertilizationValue = CGFloat(plantData[selectedPlant.id].fertilizationFactor)
                                }
                            }
                            
                    }.padding(.bottom)
                    
                    Text("Solid, liquid or organic?")
                    .bold()
                    .padding(.bottom, 5)
                    
                    Text("Fertilizers come in different shape or forms. Most commonly used are liquids and powders due to their ease of use. The fertilizers are diluted in water and then used when watering your plants.").padding(.bottom, 5).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    Text("The more uncommon route is to take fertiliziers that release pellets over time and supplement your plants continously. The downside here is that you could potentially over-fertilize your plants.").padding(.bottom, 5).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    Text("Whether you chose chemical or organic fertilizers won't impact your results. They both accomplish the same thing with different approaches. Overall organic fertilizers tend to be better for the enviroment but might come with an interesting smell.").padding(.bottom, 5).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                }.lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct FertilizationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FertilizationView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            FertilizationView(moreInfo: Binding.constant("moreFertilization"))
                .environmentObject(SelectedPlant())
        }
    }
}
