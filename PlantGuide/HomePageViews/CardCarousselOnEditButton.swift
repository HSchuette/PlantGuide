//
//  CardCarousselOnEditButton.swift
//  PlantGuide
//
//  Created by (non work) on 13.11.20.
//

import SwiftUI

struct CardCarousselOnEditButton: View {
    @Binding var onEdit: Bool
    
    var body: some View {
            
        Button(action: {
            
            onEdit.toggle()
        
        }, label: {
            Text(onEdit ? "Done" : "Edit")
                .font(.subheadline)
        })
    }
}

struct CardCarousselOnEditButton_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselOnEditButton(onEdit: Binding.constant(true))
    }
}
