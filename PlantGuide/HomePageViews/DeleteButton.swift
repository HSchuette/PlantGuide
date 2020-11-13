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
                        
                }.frame(width: 30, height: 30)
            }
            
            Spacer()
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
