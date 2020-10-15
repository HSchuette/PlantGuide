//
//  ContentView.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selected: Int?
    @State var lightMeter: Int?
    @State var waterMeter: Double?
    @State var humidityMeter: Int?
    @State var learnMore: Bool

    @State var isMenuOpen: Bool = true
    @State var showClassification: Bool = false

    let feedback = UIImpactFeedbackGenerator(style: .light)

    var body : some View {
        ZStack {
            NavigationView {
                ZStack {
                    
                    VStack {
                            // Plant Detail Screen
                            PlantOverView(selected: $selected,  lightMeter: $lightMeter, waterMeter: $waterMeter, humidityMeter: $humidityMeter)
                        
                        
                        
                        // Carousel
                        VStack{
                            HStack {
                                Text("Choose your plant:")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(.systemGray))
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        self.learnMore.toggle()
                                        self.feedback.impactOccurred()
                                    }
                                    
                                }, label: {
                                    if selected == nil {
                                    } else {
                                        Text("Learn more")
                                            .font(.subheadline)
                                        
                                        Image(systemName: "chevron.up")
                                            .font(.subheadline)
                                    }
                                }).sheet(isPresented: $learnMore, content: {
                                    PlantDetail(selected: self.$selected)
                                })
                                
                            }.padding(.leading, 25)
                            .padding(.trailing, 40)
                            .padding(.bottom, -15)
                            
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack {
                                    
                                    IdleScanView(showClassification: $showClassification, selected: $selected)
                                    
                                    ForEach(plantData, id: \.id) { plant in
                                        PlantPreview(plants: plant, selected: self.$selected)
                                            .onTapGesture {
                                                // TapGesture
                                                if self.selected == plant.id {
                                                    
                                                    // Animation of the exit motion
                                                    withAnimation(.easeInOut(duration: 0.4)) {
                                                        self.selected = nil
                                                    }
                                                    
                                                } else if self.selected == nil {
                                                    withAnimation(.easeInOut(duration: 0.4)) {
                                                        
                                                        self.selected = plant.id
                                                        self.lightMeter = plant.lightFactor
                                                        self.waterMeter = plant.waterFactor
                                                        self.humidityMeter = plant.humidityFactor
                                                    }
                                                } else {
                                                    withAnimation(.default) {
                                                        self.selected = plant.id
                                                    }
                                                    
                                                    // Animation of the meters
                                                    withAnimation(.default) {
                                                        self.lightMeter = plant.lightFactor
                                                        self.waterMeter = plant.waterFactor
                                                        self.humidityMeter = plant.humidityFactor
                                                    }
                                                }
                                        }
                                    }
                                MailView()
                                    
                                }.padding(.leading, 15.0)
                            }
                        }
                    }
                    
                    HideView(isMenuOpen: isMenuOpen)
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 1)) {
                                self.isMenuOpen = false
                                self.feedback.impactOccurred()
                            }
                        }
                    HStack {
                        Spacer()
                        
                        OptionWheel(isMenuOpen: self.$isMenuOpen)
                            .offset(x: 100, y: 60)
                    }
                    
                }.navigationBarTitle("The Plant Room", displayMode: .large)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 1).delay(1)) {
                        
                        self.selected = 0
                        self.lightMeter = plantData[0].lightFactor
                        self.waterMeter = plantData[0].waterFactor
                        self.humidityMeter = plantData[0].humidityFactor
                    }
                }
            }
        }
    }
    func HideView(isMenuOpen: Bool) -> some View {
        Color.black
            .opacity(isMenuOpen ? 0.1 : 0)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(selected: 1, lightMeter: 1, waterMeter: 1, humidityMeter: 1, learnMore: false, isMenuOpen: false, showClassification: false)
                .preferredColorScheme(.dark)
            ContentView(selected: nil, lightMeter: nil, waterMeter: nil, humidityMeter: nil, learnMore: false, isMenuOpen: false, showClassification: false)
        }
    }
}


