//
//  NavigationHeaderBar.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct NavigationHeaderBar: View {
    @Binding var isAboutVisible: Bool
    @Binding var isTutorialVisible: Bool
    
    var body: some View {
        HStack {
            Spacer()

                Button(action: {
                    print("Display Info")
                    withAnimation() {
                        isAboutVisible.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .padding(7.5)
                    
                })                            
            
            Button(action: {
                print("Display Tutorial")
                withAnimation() {
                    isTutorialVisible.toggle()
                }
                
            }, label: {
                Image(systemName: "questionmark.circle")
                    .font(.title3)
                    .padding(7.5)
                
            })
        }
    }
}

struct NavigationHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderBar(isAboutVisible: Binding.constant(false), isTutorialVisible: Binding.constant(false))
    }
}
