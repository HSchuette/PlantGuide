//
//  SettingsView.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct SettingsView: View {

    @State private var onAppear: Bool = false
    @Binding var isSettingsVisible: Bool
    
    var blue = Color("welcomeBlue")
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        if isSettingsVisible == false {
            EmptyView()
        } else {
            ZStack {
                Rectangle()
                    .opacity(0.6)
                    .foregroundColor(.black)
                
                VStack {
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemGray6))
                            .edgesIgnoringSafeArea(.all)
                            .cornerRadius(15)
                        
                        VStack {
                            Spacer()
                            SettingsDisplayView()
                                .frame(height: 450)
                        }
                        
                        VStack {
                            HStack {
                                
                                Button(action: {
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        isSettingsVisible.toggle()
                                        self.feedback.impactOccurred()
                                        onAppear = false
                                        
                                    }
                                    
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .foregroundColor(Color(.label))
                                        .opacity(0.3)
                                })
                                Spacer()
                            }
                            Spacer()
                        }
                    }.frame(height: 500)
                    .clipped()
                    .shadow(radius: 10)
                    .offset(y: onAppear ? 1 : 800)
                    .animation(.easeInOut)
                }
            }.edgesIgnoringSafeArea(.all)
            .onAppear() {
                onAppear = true
            }
            .onDisappear() {
                onAppear = false
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isSettingsVisible: Binding.constant(true))
    }
}
