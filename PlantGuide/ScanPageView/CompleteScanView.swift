//
//  CompleteScanView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct CompleteScanView: View {
    var body: some View {
        VStack {
            
            ScanPageView()
            
            VStack() {
                Spacer()
                Text("Don't know which plant you have at home?")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .kerning(-2)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack() {
                    Spacer()
                    ScanButton()
                    Spacer()
                    ScanButton()
                    Spacer()
                }
                
            }.padding()
        }
    }
}

struct CompleteScanView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteScanView()
    }
}
