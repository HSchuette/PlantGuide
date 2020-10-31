//
//  WelcomeView.swift
//  PlantGuide
//
//  Created by (non work) on 27.10.20.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var stage: String = "one"
    
    var blue = Color("welcomeBlue")
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(blue)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 1)) {
                            self.presentationMode.wrappedValue.dismiss()
                            self.feedback.impactOccurred()
                        }
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .foregroundColor(Color(.white))
                    })
                    
                }
                
                Spacer()
            }
            
            VStack {
                
                if self.stage == "one" {
                    IllustrationView()
                        .transition(.moveOutIn)
                } else {
                    HowToView()
                        .transition(.moveOutIn)
                }
               
                
                Button(action: {
                    withAnimation(.easeIn(duration: 1)) {
                        if self.stage == "one" {
                            
                            self.stage = "two"
                        } else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        self.feedback.impactOccurred()
                    }
                    
                }, label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(20)
                                .foregroundColor(Color(.white))
                                .padding([.leading,.trailing], 50)
                                .frame(height: 80)
                            
                            Text("Continue")
                                .bold()
                        }.padding(.bottom, 20)
                })

                Spacer()
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            WelcomeView()
                .preferredColorScheme(.dark)
        }
            
    }
}

extension AnyTransition {
    static var moveOutIn: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
