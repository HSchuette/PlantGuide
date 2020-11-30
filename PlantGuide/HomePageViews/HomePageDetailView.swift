//
//  HomePageDetailView.swift
//  PlantGuide
//
//  Created by (non work) on 25.11.20.
//

import SwiftUI

struct HomePageDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var detailPlant: DetailPlant
    
    var plant: DetailPlant
    let plantLight = ["smoke.fill", "cloud.sun.fill", "sun.max.fill"]
    
    let plantTypes = plantData.map { $0.name }
    
    var body: some View {
        
        VStack {
            ZStack {
                Image(uiImage: ImageStore.retrieve(imageNamed: "\(plant.id).jpg") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200.0)
                    .clipped()
                
                LinearGradient(gradient: Gradient(colors: [Color(.black).opacity(0), Color(.black).opacity(0.8)]),startPoint: .top, endPoint: .bottom)
                    .foregroundColor(Color(.systemBackground))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 200.0)
                    .clipped()
                
                VStack {
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .cornerRadius(2)
                        .frame(width: 50, height: 5)
                        .padding(10)
                    
                    Spacer()
                    
                    Image(uiImage: ImageStore.retrieve(imageNamed: "\(plant.id).jpg") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120)
                        .cornerRadius(20.0)
                        .offset(y: 60)
                        .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 5, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                        )
                    
                }.frame(height: 200.0)
                
            }.frame(height: 200.0)
            .padding(.bottom, 50)
            
            Text(plant.name)
                .font(.system(size: 35))
                .fontWeight(.bold)
                .kerning(-2)
                .padding(25)
            
            ZStack {
              Rectangle()
                .foregroundColor(Color(.systemBackground))
                .cornerRadius(20.0)
                .padding(.horizontal, 30)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("LIGHT DETAILS")
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .font(.footnote)
                            .opacity(0.6)
                            
                        Image(systemName: "\(plant.lightCategory)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        
                        
                    }.frame(width: 150)
                    
                    Divider()
                    
                    VStack {
                        Text("WATER DETAILS")
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .font(.footnote)
                            .opacity(0.6)
                        
                        VStack {
                            Image(systemName: "cloud.rain.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                            
                            Text("\(DateHelper.getDateString(date: plant.dateLastWatering))")
                                        
                        }.frame(width: 150)
                    }
                    
                    Spacer()
                }
            }.frame(height: 120)
            
            HStack {
                Text("PLANT TYPE")
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                    .opacity(0.6)
                    .padding([.leading, .top], 20)
                
                Spacer()
            }
            
            ResultPreview(selected: Binding.constant(plantTypes.firstIndex(of: plant.type)), animate: false)
            
            
            Spacer()
        }.background(Color(.systemGray6))
    }
}

struct HomePageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDetailView(plant: DetailPlant())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DetailPlant())
    }
}

