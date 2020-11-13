//
//  EditButton.swift
//  PlantGuide
//
//  Created by (non work) on 13.11.20.
//

import SwiftUI

struct EditButton: View {
    @Binding var onEdit: Bool
    
    var body: some View {
        
        Button(action: {
            onEdit.toggle()
        }, label: {
            Text(onEdit ? "Done" : "Edit")
        })
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton(onEdit: Binding.constant(true))
    }
}
