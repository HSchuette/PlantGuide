//
//  ScanPageView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI


struct ScanPageView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var isAnimating: Bool = false
    
    @Binding var image: UIImage?
    
    var body: some View {
        
        ZStack {
            
            Image(uiImage: image ?? UIImage(named: "placeHolder")!)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .cornerRadius(20)
            
            Group {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(.white))
                    .opacity(0.4)
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round, dash: [95], dashPhase: 145))
                    
                    .foregroundColor(Color(.white))
            }.frame(width: 200, height: 200)
        
            ZStack(alignment: .top) {
                
                Rectangle()
                    .fill(Color(.white))
                    .frame(width: 200, height: 4)
                
                LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.1), Color(.white)]),startPoint:  .bottom, endPoint: .top)
                    .frame(width: 200, height: 80)
                
            }.offset(y: isAnimating ? -250 : 250)
            .frame(width: 200, height: 200)
            .clipShape(
                RoundedRectangle(cornerRadius: 25)
            )
            .animation(Animation.linear(duration: 3).delay(6))
            
            ZStack(alignment: .bottom) {
                
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(width: 200, height: 4)
                
                LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.white).opacity(0.1)]),startPoint:  .bottom, endPoint: .top)
                    .frame(width: 250, height: 80)
                
            }.offset(y: isAnimating ? 250 : -250)
            .frame(width: 200, height: 200)
            .clipShape(
                RoundedRectangle(cornerRadius: 25)
            )
            .animation(Animation.linear(duration: 3).delay(3))
            
            LogoAsset()
                .stroke(lineWidth: 7)
                .frame(width: 50, height: 50)
                .foregroundColor(Color(.white))
                
            
        }
        .clipped()
        .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.1 : 0), radius: 4, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
        )        
        .onAppear() {
            self.isAnimating = true            
        }
    }
}


struct ScanPageView_Previews: PreviewProvider {
    static var previews: some View {
        ScanPageView(image: Binding.constant(UIImage(named: "test")))
            .preferredColorScheme(.dark)
    }
}
