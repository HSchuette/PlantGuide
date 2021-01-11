//
//  SettingsView.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isSettingsVisible: Bool
    @State private var onAppear: Bool = false
    
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
                            .foregroundColor(blue)
                            .edgesIgnoringSafeArea(.all)
                            .cornerRadius(15)
                        
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
                                        .foregroundColor(Color(.black))
                                        .opacity(0.3)
                                })
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        VStack {
                            SettingsDisplayView()
                        }
                    }.frame(height: 400)
                    .clipped()
                    .shadow(radius: 10)
                    .offset(y: onAppear ? 0 : 500)
                    .animation(.easeIn)
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
