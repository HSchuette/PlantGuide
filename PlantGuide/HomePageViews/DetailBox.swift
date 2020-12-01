//
//  DetailBox.swift
//  PlantGuide
//
//  Created by (non work) on 01.12.20.
//

import SwiftUI

struct DetailBox: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let leftText: String
    let leftIconName: String
    let leftInfoText: String
    
    let rightText: String
    let rightIconName: String
    let rightInfoText: String
    
    var body: some View {
        ZStack {
          Rectangle()
            .foregroundColor(Color(.systemBackground))
            .cornerRadius(10.0)
            .padding(.horizontal, 30)
            .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 5, y: 5)
            
            
            HStack {
                Spacer()
                
                DetailStack(text: leftText, iconName: leftIconName, infoText: leftInfoText)
                
                Divider()
                
                DetailStack(text: rightText, iconName: rightIconName, infoText: rightInfoText)
                
                Spacer()
            }
        }.frame(height: 120)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                .padding(.horizontal, 30)
        )
    }
}

struct DetailBox_Previews: PreviewProvider {
    static var previews: some View {
        DetailBox(leftText: "test", leftIconName: "sun.max.fill", leftInfoText: "text", rightText: "test", rightIconName: "sun.max.fill", rightInfoText: "text")
    }
}
