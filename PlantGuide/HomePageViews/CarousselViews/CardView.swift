//
//  CardView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct CardView: View {
    

    
    var plantName: String
    var plantType: String
    var plantID: String?
    
    var blue = Color("blue")
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Image(uiImage: ImageStore.retrieve(imageNamed: "\(plantID!).png") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 225)
                        .offset(y: -55)
                        .onAppear() {
                            print("\(plantID!).png")
                        }
                        
                }
                VStack {
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemBackground))
                            .cornerRadius(25)
                        
                        VStack(alignment: .leading) {
                            Text(plantName)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .kerning(-1)
                            
                            Text(plantType)
                                .font(.system(size: 12))
                                .italic()
                                .opacity(0.7)
                                                    
                            HStack(alignment: .bottom) {
                                Spacer()
                                
                                CircleIcon(color: blue, image: "cloud.rain.fill")
                                Spacer()
                                CircleIcon(color: Color(.systemGray2), image: "cloud.fog.fill")
                                Spacer()
                            }.scaleEffect(0.8)
                        }.padding(.horizontal, 15)
                        .frame(width: 140)
                        
                        
                    }.frame(width: 150, height: 112.5)
                    .clipped()
                    .shadow(color: Color(UIColor.black).opacity(0.2), radius: 4, x: 0, y: -5)
                    
                }
                
                
                
            }.cornerRadius(25)
            .frame(width: 150, height: 225)
            .shadow(color: Color(UIColor.black).opacity(0.05), radius: 4, x: 5, y: 5)
            .shadow(color: Color(.systemGray4).opacity(0.1), radius: 4, x: -5, y: -5)
            
        }.frame(width: 165, height: 240)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(plantName: "Pflanziska", plantType: "Monstera Deliciosa", plantID: nil)
    }
}

