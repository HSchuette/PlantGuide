//
//  BarMeter.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import Foundation
import SwiftUI

func BarMeter(width: CGFloat, color: Color, image: String) -> some View {
    return VStack {
        HStack(alignment: .center) {
            Spacer()
            
            ZStack {
                Rectangle()
                    .cornerRadius(15.0)
                    .foregroundColor(Color(.systemGray4))
                    .opacity(0.2)
                
                Rectangle()
                    .cornerRadius(15.0)
                    .foregroundColor(color)
                    .padding(.leading, 180-width*45)
                
                HStack {
                    Spacer()
                    
                    Image(systemName: image).foregroundColor(.white)
                        .padding(.trailing, 10)
                }
            }
        }
        Spacer()
    }.frame(width: 180, height: 40)
    .cornerRadius(15.0)
}

func CircleIcon(color: Color, image: String)
    -> some View {
        return ZStack() {
        Circle()
            .foregroundColor(color)
        Image(systemName: image).foregroundColor(.white)
    }.frame(width: 40, height: 40)
}
