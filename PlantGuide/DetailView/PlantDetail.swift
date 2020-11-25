//
//  PlantDetail.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI
import SafariServices

struct PlantDetail: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var moreInfo: String?
    
    var green = Color(red: 0.267, green: 0.451, blue: 0.216)
    var yellow = Color("yellow")
    var blue = Color("blue")
    var red = Color(red: 164/256, green: 50/256, blue: 52/256)
    
    // MARK: - Show More Button
    // button for more or less info
    func InfoButton(moreString: String)
    -> some View {
        return VStack() {
            VStack {
                Button(action: {
                    withAnimation(.easeInOut) {
                        if self.moreInfo == nil {
                            self.moreInfo = moreString
                        } else  if  self.moreInfo != moreString {
                            self.moreInfo = moreString
                        } else {
                            self.moreInfo = nil
                        }
                    }
                }, label: {
                    
                    HStack(alignment: .top) {
                        Spacer()
                        
                        Image(systemName: self.moreInfo == moreString ? "chevron.up.circle.fill" : "chevron.down.circle")
                            .font(.subheadline)
                            .scaleEffect(self.moreInfo == moreString ? 1.4 : 1.2)
                        
                    }.padding(.top, 20)
                })
            }.padding(.trailing)
        }
    }
    
    // MARK: - View
    var body: some View {
        ScrollView(.vertical) {
            
            VStack() {
                // Header
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),startPoint: .top, endPoint: .bottom)
                        .foregroundColor(Color(.systemBackground))
                        .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        Spacer()
                        
                        Image(selectedPlant.imageName)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(-25))
                            .padding(.trailing, -80)
                            .padding(.bottom, -15)
                    }
                    // title
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        HStack {
                            Text(selectedPlant.name)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .kerning(-2)
                            
                            Spacer()
                        }.frame(width: 220.0)
                        
                        
                        HStack {
                            Text(selectedPlant.latin)
                                .font(.subheadline)
                                .italic()
                                .opacity(0.7)
                            Spacer()
                        }
                    }.padding(25)
                    
                    VStack {
                        Rectangle()
                            .fill(Color(.systemGray4))
                            .cornerRadius(2)
                            .frame(width: 50, height: 5)
                            .padding(10)
                        
                        Spacer()
                    }
                    
                }
                .cornerRadius(10)
                .clipped()
                .frame(height: 200.0)
                
                // text body
                VStack(alignment: .leading) {
                    // description
                    Text(selectedPlant.description).padding(.bottom)
                    
                    // list of atributes
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color(.systemBackground))
                        VStack {
                            Group {
                                ZStack(alignment: .top) {
                                    GalleryView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreGallery")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                                
                            }
                            Group {
                                ZStack(alignment: .top) {
                                    SunView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreSun")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0))
                                    .padding(.horizontal)
                                
                            }
                            Group {
                                ZStack(alignment: .top) {
                                    WaterView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreWater")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                                
                            }
                            
                            Group {
                                ZStack(alignment: .top) {
                                    HumidityView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreHumidity")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                                
                            }
                            
                            Group {
                                ZStack(alignment: .top) {
                                    TempView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreTemp")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                            }
                            
                            Group {
                                ZStack(alignment: .top) {
                                    FertilizationView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreFertilization")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                                
                            }
                            
                            Group {
                                ZStack(alignment: .top) {
                                    ToxicityView(moreInfo: $moreInfo)
                                    
                                    InfoButton(moreString: "moreToxicity")
                                }.padding()
                                
                                Divider()
                                    .background(Color(.label).opacity(0.1))
                                    .padding(.horizontal)
                            }
                            
                            Group {
                                ZStack(alignment: .top) {
                                    WikipediaView(moreInfo: $moreInfo)
                                }.padding()
                            }
                            
                            Spacer()
                        }
                    }
                    .clipped()
                    .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 5, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                    )
                }.padding(25)
                .lineLimit(nil)
            }
        }.background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PlantDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetail()
            .preferredColorScheme(.light)
            .environmentObject(SelectedPlant())
    }
}


