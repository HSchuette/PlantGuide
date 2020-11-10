//
//  ScanButton.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct ScanButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 150, height: 100)
                .foregroundColor(.blue)
                .cornerRadius(15)
            
            VStack {
                Image(systemName: "photo.on.rectangle.angled")
                    .padding(5)
                
                Text("Photo Library")
                    .bold()
            }.foregroundColor(.white)
        }
    }
}

struct ScanButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanButton()
    }
}
