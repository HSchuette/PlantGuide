//
//  CardView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct CardView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var plantName: String
    var plantType: String
    var plantID: String?
    
    var blue = Color("blue")
    
    var body: some View {
        ZStack {
            Image(uiImage: ImageStore.retrieve(imageNamed: "\(plantID!).jpg") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                .resizable()
                .scaledToFill()
            
            VStack {
                Spacer()
                
                ZStack{
                    
                    Rectangle()
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: 120, height: 50)
                        .shadow(color: Color(.secondarySystemFill).opacity(0.25), radius: 4, x: -5, y: -5)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(plantName)
                                .font(.callout)
                                .fontWeight(.bold)
                                .kerning(-1)
                            
                            Text(plantType)
                                .font(.caption2)
                                .italic()
                                .opacity(0.7)
                        }.padding(.bottom, 5)
                        .padding(.leading, 10)
                        
                        Spacer()
                    }
                }
            }.frame(width: 120, height: 140)
        }.frame(width: 120, height: 140)
        .cornerRadius(15)
        .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.1 : 0), radius: 4, x: 3, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)                
        )
        .padding(8)
        .onAppear() {
            print("Succcesfully loaded image: \(plantID!).jpg")
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(plantName: "Testy", plantType: "Prayer Plant", plantID: "fztguiopiuhig")
            
            
        
    }
}

