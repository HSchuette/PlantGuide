//
//  AboutScreen.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct AboutView: View {
    @Binding var isAboutVisible: Bool
    
    var blue = Color("welcomeBlue")
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        if isAboutVisible == false {
            EmptyView()
        } else {
            ZStack {
                Rectangle()
                    .opacity(0.6)
                
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
                                        isAboutVisible.toggle()
                                        self.feedback.impactOccurred()
                                       
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
                            
                            Spacer()
                                ZStack {
                                    
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(25)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                                                
                                    VStack(alignment: .center) {
                                        Image("qr-code")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 160, height: 160)
                                        
                                        
                                        Text("Sharing is caring!")
                                            .font(.body)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            
                                    }
                                    
                                }.frame(width: 200, height: 250)
                                
                                Spacer()
                                
                                Group {
                                    Text("Made with ♥")
                                    Text("by Hendrik Schuette, 2021")
                                }.foregroundColor(.white)
                            }.padding(.bottom, 35)
                                                    
                    }.frame(height: 400)
                    .clipped()
                    .shadow(radius: 10)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(isAboutVisible: Binding.constant(true))
    }
}
