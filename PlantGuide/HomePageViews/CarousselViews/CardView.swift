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
            Image(uiImage: ImageStore.retrieve(imageNamed: "\(plantID!).png") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                .resizable()
                .scaledToFill()
            
            VStack {
                Spacer()
                
                ZStack{
                    
                    Rectangle()
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: 120, height: 50)
                        .shadow(color: Color(.secondarySystemFill).opacity(0.25), radius: 4, x: -5, y: -5)
                    
                    VStack(alignment: .leading) {
                        Text(plantName)
                            .font(.callout)
                            .fontWeight(.bold)
                            .kerning(-1)
                        
                        Text(plantType)
                            .font(.caption2)
                            .italic()
                            .opacity(0.7)
                    }
                }
            }.frame(width: 120, height: 140)
        }.frame(width: 120, height: 140)
        .cornerRadius(15)
        .shadow(color: Color(UIColor.black).opacity(0.2), radius: 4, x: 5, y: 5)
        .shadow(color: Color(.systemGray4).opacity(0.1), radius: 4, x: -5, y: -5)
        .padding(8)
        .onAppear() {
            print("\(plantID!).png")
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(plantName: "Pflanziska", plantType: "Monstera Deliciosa", plantID: "fztguiopiuhig")
            
    }
}

