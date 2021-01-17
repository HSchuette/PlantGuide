//
//  CarousselToppingView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct CarousselToppingView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @Binding var showLearnMoreSheet: Bool
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        // Carousel
        VStack{
            HStack {
                Text("Choose your plant:")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.showLearnMoreSheet.toggle()
                        self.feedback.impactOccurred()
                    }
                    
                }, label: {
                    Text("Learn more")
                        .font(.subheadline)
                    
                    Image(systemName: "chevron.up")
                        .font(.subheadline)
                }).sheet(isPresented: $showLearnMoreSheet, content: {
                    PlantDetail()
                })
                
            }.padding(.leading, 25)
            .padding(.trailing, 40)            
        }
    }
}

struct CarousselToppingView_Previews: PreviewProvider {
    static var previews: some View {
        CarousselToppingView(showLearnMoreSheet: Binding.constant(false))
            .environmentObject(SelectedPlant())
    }
}
