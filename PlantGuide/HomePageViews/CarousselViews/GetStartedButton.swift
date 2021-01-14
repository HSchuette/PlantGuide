//
//  GetStartedButton.swift
//  PlantGuide
//
//  Created by (non work) on 14.11.20.
//

import SwiftUI

struct GetStartedButton: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var showAddFirstSheet = false
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    let colorSelected = [Color(.systemBackground),  Color(.systemBackground)]
    
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
                        Text("Add Plant")
                            .font(.system(size: 20))
                            .bold()
                            
                        Spacer()
                    }.frame(width: 200.0)
                        
                    
                    HStack {
                        Text("Add your first plant now")
                            .font(.footnote)
                            .italic()
                            .opacity(0.7)
                        Spacer()
                    }
                }.padding(25)
                
                
            }
            .clipped()
            .cornerRadius(10)
            .frame(width: 325, height: 100)
            .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.1 : 0), radius: 4, x: 3, y: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
            )
            .padding(.vertical, 50)

            
        }).sheet(isPresented: $showAddFirstSheet, content: {
            AddNewPlantSheetView()
        })
        .accentColor(Color("welcomeBlue"))
    }
}

struct GetStartedButton_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedButton()
            
    }
}
