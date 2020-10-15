//
//  PicturePreview.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct PicturePreview: View {
    
    @Binding var image: UIImage?
    
    @State private var switchOn: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round, dash: [120], dashPhase: 180))
                .frame(width: 250, height: 250)
                .foregroundColor(Color(.systemGray6))
                .scaleEffect(self.switchOn ? 1 : 0.5)
                .blur(radius: self.switchOn ? 0 : 2)
                .animation(Animation.easeInOut(duration: 1.5))
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round, dash: [120], dashPhase: 180))
                .frame(width: 250, height: 250)
                .foregroundColor(Color(.systemGray6))
                .scaleEffect(self.switchOn ? 1 : 1.5)
                .opacity(self.switchOn ? 0.5 : 0)
                .blur(radius: 2)
                .animation(Animation.easeInOut(duration: 1.5).delay(0.8))
            
            ZStack {
                Image(uiImage: image ?? UIImage(named: "placeHolder")!)
                    .resizable()
                    .cornerRadius(25)
                    .aspectRatio(image!.size, contentMode: .fit)
                    .frame(width: 300, height: 300)
                    
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemBackground).opacity(0.1)]),startPoint: .trailing, endPoint: .leading)
                    .frame(width: 100)
                    .offset(x: switchOn ? +200 : -200)
                    .animation(.easeIn(duration: 1))
                
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemBackground).opacity(0.1)]),startPoint: .bottom, endPoint: .top)
                .frame(height: 100)
                .offset(y: switchOn ? +200 : -200)
                    .animation(Animation.easeIn(duration: 1).delay(0.8))
                
                
            }.frame(width: 200, height: 200)
            .cornerRadius(25)
            .shadow(radius: 5)
            .onAppear() {
                self.switchOn = true
            }
        }
        
    }
}

struct PicturePreview_Previews: PreviewProvider {
    static var previews: some View {
        PicturePreview(image: Binding.constant(UIImage(named: "test")))
    }
}
