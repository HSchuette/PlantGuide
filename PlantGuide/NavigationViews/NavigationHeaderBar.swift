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
    @Binding var isSettingsVisible: Bool
    
    let buttonColor: Color = Color(.systemGray)
    
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
                        .padding(5)
                        .foregroundColor(buttonColor)
                    
                })                            
            
            Button(action: {
                print("Display Tutorial")
                withAnimation() {
                    isTutorialVisible.toggle()
                }
                
            }, label: {
                Image(systemName: "questionmark.circle")
                    .font(.title3)
                    .padding(5)
                    .foregroundColor(buttonColor)
                
            })
            
            Button(action: {
                print("Display Settings")
                withAnimation() {
                    isSettingsVisible.toggle()
                }
                
            }, label: {
                Image(systemName: "gear")
                    .font(.title3)
                    .padding(5)
                    .foregroundColor(buttonColor)
                
            })
        }
    }
}

struct NavigationHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderBar(isAboutVisible: Binding.constant(false), isTutorialVisible: Binding.constant(false), isSettingsVisible: Binding.constant(false))
    }
}
