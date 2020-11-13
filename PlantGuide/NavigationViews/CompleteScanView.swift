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
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Identify your favourite plant by snapping a picture with your phone.")
                
                Spacer()
                
                Text("Choose your input:")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                
                HStack() {
                    Spacer()
                    ScanButton(systemName: "photo.on.rectangle.angled", description: "Photo Library")
                    Spacer()
                    ScanButton(systemName: "camera", description: "Camera")
                    Spacer()
                }
                
            }.padding(.horizontal, 25)
        }
    }
}

struct NavigationScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScanView()
    }
}
