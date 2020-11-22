//
//  CompleteScanView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct NavigationScanView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Spacer()
            
            ScanPageView()
            
            Spacer()
            
            Text("Identify your favourite plant by snapping a picture with your phone.")
                .font(.callout)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Text("Choose your input:")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                    
                
                Spacer()
            }.padding()
                
            VStack {
                Button(action: {

                    
                }, label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        
                        Text("Photo Library")
                    }
                    
                    
                }).buttonStyle(CustomButtonStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(colorScheme == .light ? .clear : Color(.white))
                )
                    
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image(systemName: "camera")
                        
                        Text("Camera")
                    }
                }).buttonStyle(CustomButtonStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(colorScheme == .light ? .clear : Color(.white))
                )
                .padding(5)
                                
            }
            Spacer()
            
        }.padding(.horizontal, 25)
    }
}

struct NavigationScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScanView()
    }
}


struct CustomButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 250, height: 50)
            .foregroundColor(configuration.isPressed ? Color(.systemBackground) : /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .background(Color(configuration.isPressed ? .systemBlue : .systemBackground))
            .cornerRadius(10)
            .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 3, y: 3)
    }
}
