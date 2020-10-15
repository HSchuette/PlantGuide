//
//  ClassificationPlantDetail.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct ClassificationPlantDetail: View {
    
    @Binding var selected: Int?
    @Binding var image: UIImage?
    @GestureState private var dragOffset = CGSize.zero
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    PlantDetail(selected: self.$selected)
                    
                    VStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10)
                                .padding([.leading, .top], 25)
                                .foregroundColor(Color(.systemBlue))
                            }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("", displayMode: .large)
            .navigationBarHidden(true)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }))
        }
    }
}

struct ClassificationPlantDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationPlantDetail(selected: Binding.constant(1), image: Binding.constant(nil))
    }
}
