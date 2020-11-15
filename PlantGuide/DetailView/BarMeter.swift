//
//  BarMeter.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import Foundation
import SwiftUI

func BarMeter(width: CGFloat, color: Color, image: String, isWide: Bool) -> some View {
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
                    .padding(.leading, (isWide ? 300 : 180)-width*(isWide ? 75 : 45))
                
                if isWide == false {
                } else {
                    HStack {
                        Rectangle()
                            .cornerRadius(5.0)
                            .foregroundColor(Color(.systemGray))
                            .opacity(0.5)
                            .frame(width: 5, height: 25)
                            .padding(.leading, 320-width*75)
                        Spacer()
                    }
                }
                    
                
                HStack {
                    Spacer()
                    
                    Image(systemName: image).foregroundColor(.white)
                        .padding(.trailing, 10)
                }
            }
        }
    }.frame(width: isWide ? 300 : 180, height: 40)
    .cornerRadius(15.0)
}

struct BarMeter_Previews: PreviewProvider {
    static var previews: some View {
        BarMeter(width: 2, color: .yellow, image: "sun.max.fill", isWide: true)
    }
}

func CircleIcon(color: Color, image: String)
    -> some View {
        return ZStack() {
        Circle()
            .foregroundColor(color)
        Image(systemName: image).foregroundColor(.white)
    }.frame(width: 40, height: 40)
}
