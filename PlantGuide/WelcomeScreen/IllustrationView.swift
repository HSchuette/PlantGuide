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
            
            Text("Hello there!")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .kerning(-2)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(.white))
                .animation(.easeInOut)
            
            Image("welcomeScreenIllustration")
                .resizable()
                .shadow(color: Color(.systemBackground).opacity(0.1), radius: 4, x: 5, y: 5)
                .frame(width: 150, height: 150)
                .scaledToFit()
                .padding()
                .shadow(radius: 5)
            
            Spacer()
        }.frame(height: 400)        
    }
}

struct IllustrationView_Previews: PreviewProvider {
    static var previews: some View {
        IllustrationView()
            .preferredColorScheme(.dark)
    }
}
