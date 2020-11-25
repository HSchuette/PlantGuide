//
//  ResultPreview.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct ResultPreview: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var selected: Int?
    
    @State private var switchOn: Bool = false
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(.systemBackground))
            
            if selected == 999 {
                Text("Sadly we could not classify your houseplant sufficiently. Feel free to send us a mail with a photo of the plant so I can add it in the future.")
                    .lineLimit(nil)
                    .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            } else {
                HStack {
                    Spacer()
                    
                    Image(plantData[selected!].imageName)
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
                        Text(plantData[selected!].name)
                            .font(.system(size: 20))
                            .bold()
                            
                        Spacer()
                    }.frame(width: 200.0)
                        
                    
                    HStack {
                        Text(plantData[selected!].latin)
                            .font(.footnote)
                            .italic()
                            .opacity(0.7)
                        Spacer()
                    }
                }.padding(25)
            }
            
            
        }
        .clipped()
        .cornerRadius(10)
        .frame(width: 325, height: 100)
        .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
        )    
        .padding(5)
        .offset(y: switchOn ? 0 : +1000)
        .animation(Animation.easeInOut(duration: 1.3).delay(0.8))
        .onAppear() {
                self.switchOn = true
        }
         
        }
}

struct ResultPreview_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview(selected: Binding.constant(2))
    }
}
