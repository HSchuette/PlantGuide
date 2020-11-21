//
//  DeleteButton.swift
//  PlantGuide
//
//  Created by (non work) on 12.11.20.
//

import SwiftUI

struct DeleteButton: View {
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .foregroundColor(Color(.systemBackground))
                    
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .scaledToFill()
                        
                }.frame(width: 25, height: 25)
            }
            
            Spacer()
        }.frame(height: 145)
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
