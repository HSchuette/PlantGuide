//
//  ScanButton.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct ScanButton: View {
    let colorSelected = [Color(.systemBackground),  Color(.systemGray5)]

    var systemName: String
    var description: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colorSelected), startPoint: .top, endPoint: .bottom)
                .frame(height: 100.0)
                .foregroundColor(Color(.systemGray5))
                .cornerRadius(20)
            
            VStack {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60.0, height: 70)
                    .padding(5)
                    
                
                Text(description)
                    .font(.caption)
                
                Spacer()
            }
        }.frame(width: 105, height: 150)
        .clipped()
        .shadow(color: Color(UIColor.black).opacity(0.2), radius: 4, x: 5, y: 5)
        .shadow(color: Color(.systemGray4).opacity(0.1), radius: 4, x: -5, y: -5)
    }
}

struct ScanButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanButton(systemName: "photo.on.rectangle.angled", description: "Photo Library")
    }
}
