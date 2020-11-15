//
//  CompleteScanView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct NavigationScanView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            ScanPageView()
            
            VStack {
                
                Text("Identify your favourite plant by snapping a picture with your phone.")
                    .padding()
                
                HStack {
                    Text("Choose your input:")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.systemGray))
                    
                    Spacer()
                    
                }.padding()
                
                
                Button(action: {

                    
                }, label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        
                        Text("Photo Library")
                    }
                    
                    
                }).buttonStyle(CustomButtonStyle())
                    
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image(systemName: "camera")
                        
                        Text("Camera")
                    }
                }).buttonStyle(CustomButtonStyle())
                
               
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
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 250, height: 50)
            .foregroundColor(configuration.isPressed ? Color(.systemBackground) : /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .background(Color(configuration.isPressed ? .systemBlue : .systemGray6))
            .cornerRadius(10)
            .padding(5)
            .shadow(color: Color(UIColor.black).opacity(0.1), radius: 4, x: 2, y: 2)
    }
}
