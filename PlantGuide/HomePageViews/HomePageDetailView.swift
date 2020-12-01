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
        
        ScrollView {
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
                        .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 5, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                        )
                        .offset(y: 60)
                    
                }.frame(height: 200.0)
                
            }.frame(height: 200.0)
            .padding(.bottom, 50)
                        
            Text(plant.name)
                .font(.system(size: 35))
                .fontWeight(.bold)
                .kerning(-2)
                .padding(25)
            
            ResultPreview(selected: Binding.constant(plantTypes.firstIndex(of: plant.type)), animate: false)
                .padding(.bottom)
            
            DetailBox(leftText: "LIGHT DETAILS", leftIconName: "\(plant.lightCategory)", leftInfoText: "\(String(format: "%.0f%%",  plant.lightFactor/4*100))", rightText: "DATE ADDED", rightIconName: "calendar.badge.plus", rightInfoText: "\(DateHelper.getDateString(date: plant.dateAdded))")
            
            DetailBox(leftText: "LAST WATERING", leftIconName: "cloud.rain", leftInfoText: "\(DateHelper.getDateString(date: plant.dateLastWatering))", rightText: "NEXT WATERING", rightIconName: "cloud.rain.fill", rightInfoText: "\(DateHelper.getDateString(date: plant.dateNextWatering))")
            
            DetailBox(leftText: "WATER REMINDER", leftIconName: plant.isWaterReminder ? "checkmark.circle.fill": "xmark.circle", leftInfoText: plant.isWaterReminder ? "Active" : "Inactive", rightText: "HUMIDITY REMINDER", rightIconName: plant.isHumidityReminder ? "checkmark.circle.fill": "xmark.circle", rightInfoText: plant.isHumidityReminder ? "Active" : "Inactive")
            
            Spacer()
        }.background(Color(.systemGray6))
    }
}

struct HomePageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDetailView(plant: DetailPlant())
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DetailPlant())
    }
}

