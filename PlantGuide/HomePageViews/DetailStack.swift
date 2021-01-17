//
//  detailStack.swift
//  PlantGuide
//
//  Created by (non work) on 01.12.20.
//

import SwiftUI

struct DetailStack: View {
    
    let text: String
    let iconName: String
    let infoText: String
    
    var body: some View {
        VStack {
            Text(text)
                .fontWeight(.regular)
                .font(.footnote)
                .opacity(0.6)
                
            
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                
                Text(infoText)
            }
        }.frame(width: 150)
    }
}

struct DetailStackAddition_Previews: PreviewProvider {
    static var previews: some View {
        DetailStack(text: "blah", iconName: "plus", infoText: "balh")
    }
}
