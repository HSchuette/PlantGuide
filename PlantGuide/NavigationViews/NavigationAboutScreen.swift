//
//  NavigationAboutScreen.swift
//  PlantGuide
//
//  Created by (non work) on 25.12.20.
//

import SwiftUI

struct NavigationAboutScreen: View {
    @Binding var isAboutVisible: Bool
    
    var body: some View {
        HStack {            
            Spacer()

                Button(action: {
                    print("Display Info")
                    
                    isAboutVisible.toggle()
                    
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.title3)
                    
                })
                .alert(isPresented: $isAboutVisible, content: {
                    Alert(title: Text("Made with ♥"), message: Text("by Hendrik Schuette, 2020"), dismissButton: .default(Text("Cancel")))
            })
        }.padding(.horizontal, 12)
    }
}

struct NavigationAboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationAboutScreen(isAboutVisible: Binding.constant(false))
    }
}
