//
//  GetStartedButton.swift
//  PlantGuide
//
//  Created by (non work) on 14.11.20.
//

import SwiftUI

struct GetStartedButton: View {
    @State var showAddFirstSheet = false
    let feedback = UIImpactFeedbackGenerator(style: .light)
    let colorSelected = [Color(.systemBackground),  Color(.systemGray5)]
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                self.showAddFirstSheet.toggle()
            }
            
        }, label: {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: colorSelected), startPoint: .top, endPoint: .bottom)
                    .frame(height: 100.0)
                    .foregroundColor(Color(.systemGray5))
                    .cornerRadius(20)
                
                HStack {
                    Spacer()
                    
                    Image("monsteraDeliciosa")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(-25))
                        .padding(.trailing, -40)
                        .scaleEffect(1.5)
                }
                // title
                VStack(alignment: .leading) {
                    Spacer()
                    
                    HStack {
                        Text("Get Started!")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color.black)
                            
                        Spacer()
                    }.frame(width: 200.0)
                        
                    
                    HStack {
                        Text("Add your first plant now")
                            .font(.footnote)
                            .italic()
                            .opacity(0.7)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                }.padding(25)
                
                
            }
            .clipped()
            .cornerRadius(10)
            .frame(width: 325, height: 100)
            .shadow(radius: 5)
            .padding(50)

            
        }).sheet(isPresented: $showAddFirstSheet, content: {
            AddNewSheet()
        })
    }
}

struct GetStartedButton_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedButton()
    }
}
