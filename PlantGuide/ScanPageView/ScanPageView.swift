//
//  ScanPageView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct ScanPageView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Image("placeHolder")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 350)
                .cornerRadius(20)
            
            Group {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(.systemGray6))
                    .opacity(0.4)
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round, dash: [120], dashPhase: 180))
                    
                    .foregroundColor(Color(.systemGray6))
            }.frame(width: 250, height: 250)
        
            ZStack(alignment: .top) {
                
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(width: 250, height: 4)
                
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground).opacity(0.1), Color(.systemBackground)]),startPoint:  .bottom, endPoint: .top)
                    .frame(width: 250, height: 80)
                
            }.offset(y: isAnimating ? -300 : 300)
            .frame(width: 250, height: 250)
            .clipShape(
                RoundedRectangle(cornerRadius: 25)
            )
            .animation(Animation.linear(duration: 3).delay(6).repeatForever(autoreverses: false))
            
            ZStack(alignment: .bottom) {
                
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(width: 250, height: 4)
                
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemBackground).opacity(0.1)]),startPoint:  .bottom, endPoint: .top)
                    .frame(width: 250, height: 80)
                
            }.offset(y: isAnimating ? 300 : -300)
            .frame(width: 250, height: 250)
            .clipShape(
                RoundedRectangle(cornerRadius: 25)
            )
            .animation(Animation.linear(duration: 3).delay(3).repeatForever(autoreverses: false))
            
            LogoAsset()
                .stroke(lineWidth: 8)
                .frame(width: 60, height: 60)
                .foregroundColor(Color(.systemBackground))
                
            
        }
        .clipped()
        .shadow(color: Color(UIColor.black).opacity( 0.2), radius: 8, x: 5, y: 5)
        .shadow(color: Color(.systemGray4).opacity(0.1), radius: 8, x: -5, y: -5)
        .onAppear() {
            self.isAnimating = true
        }
        .scaleEffect(0.75)
    }
    
}


struct ScanPageView_Previews: PreviewProvider {
    static var previews: some View {
        ScanPageView()
    }
}
