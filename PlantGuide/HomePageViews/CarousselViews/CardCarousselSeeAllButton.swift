//
//  CardCarousselSeeAllButton.swift
//  PlantGuide
//
//  Created by (non work) on 14.11.20.
//

import SwiftUI

struct CardCarousselSeeAllButton: View {
    @Binding var seeAll: Bool
    
    var body: some View {
            
        Button(action: {
            withAnimation(.default) {
                seeAll.toggle()
            }
        
        }, label: {
            HStack {
                Text(seeAll ? "Show less" : "Expand")
                    .font(.subheadline)
                
                Image(systemName: seeAll ? "rectangle.arrowtriangle.2.inward" : "rectangle.arrowtriangle.2.outward")
                    .font(.subheadline)
            }
        })
    }
}
struct CardCarousselSeeAllButton_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselSeeAllButton(seeAll: Binding.constant(true))
    }
}
