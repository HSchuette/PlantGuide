//
//  LogoAsset.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

struct LogoAsset: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.size.width/2, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width/2, y: rect.size.height/4*3))
            path.addLine(to: CGPoint(x: rect.size.width/3, y: rect.size.height/4*3))
            path.addLine(to: CGPoint(x: rect.size.width/3, y: rect.size.height/4*3))
            path.addArc(center: CGPoint(x: rect.size.width/3, y: rect.size.height/2), radius: rect.size.width/4, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
            path.addLine(to: CGPoint(x: rect.size.width/4, y: rect.size.height/2))
            path.addArc(center: CGPoint(x: rect.size.width/4, y: rect.size.height/4*3), radius: rect.size.width/4, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)
            path.closeSubpath()
            
            path.move(to: CGPoint(x: rect.size.width/2, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width/2, y: rect.size.height/4*2.2))
            path.addLine(to: CGPoint(x: rect.size.width/3*2, y: rect.size.height/4*2.2))
            path.addArc(center: CGPoint(x: rect.size.width/3*2, y: rect.size.height/4.6), radius: rect.size.width/3, startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
            path.addArc(center: CGPoint(x: rect.size.width/4*3.3, y: rect.size.height/4*2.2), radius: rect.size.width/3, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
            
            
        }
    }
}

struct LogoAsset_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LogoAsset()
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .square))
                .frame(width: 100, height: 100)
                .foregroundColor(Color(red: 0.227, green: 0.521, blue: 0.266))
        }
    }
}
