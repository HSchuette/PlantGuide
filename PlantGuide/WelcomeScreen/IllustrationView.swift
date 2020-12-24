//
//  IllustrationView.swift
//  PlantGuide
//
//  Created by (non work) on 31.10.20.
//

import SwiftUI

struct IllustrationView: View {
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("welcomeScreenIllustration")
                .resizable()
                .shadow(color: Color(.systemBackground).opacity(0.1), radius: 4, x: 5, y: 5)
                .frame(width: 250, height: 250)
                .scaledToFit()
                .padding()
            
            Text("Welcome!")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .kerning(-2)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(.white))
                .padding()
            
            Text("Plant Room helps you to keep track of the needs of your beloved house plants. Dive right in!")
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding()
            
            Spacer()
        }
    }
}

struct IllustrationView_Previews: PreviewProvider {
    static var previews: some View {
        IllustrationView()
    }
}
