//
//  CardCarousselAddMoreButton.swift
//  PlantGuide
//
//  Created by (non work) on 14.11.20.
//

import SwiftUI

struct CardCarousselAddMoreButton: View {
    @State var showAddNewSheet = false
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                self.showAddNewSheet.toggle()
            }
            
        }, label: {
            Text("Add more")
                .font(.subheadline)
            
            Image(systemName: "plus.circle")
                .font(.subheadline)
        }).sheet(isPresented: $showAddNewSheet, content: {
            AddNewSheet()
        })
    }
}

struct CardCarousselAddMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselAddMoreButton()
    }
}
