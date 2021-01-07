//
//  HowToView.swift
//  PlantGuide
//
//  Created by (non work) on 31.10.20.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack {
            
            Spacer()
        
            HStack {
                Text("Features")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .kerning(-2)
                    .foregroundColor(Color(.label))
                    .padding(.leading)
                
                LogoAsset()
                    .stroke(lineWidth: 5)
                    .frame(width: 35, height: 35)
                    .offset(y: -5)
                    .foregroundColor(Color(.label))
                
                Spacer()
            }.padding()
            
            VStack(alignment: .leading) {
                        InformationDetailView(title: "Identify", subTitle: "Instantly identify your plant at home by taking a picture of it.", imageName: "viewfinder")

                        InformationDetailView(title: "Overview", subTitle: "Get a quick overview of all the important needs of your favourite plants.", imageName: "chart.bar")

                        InformationDetailView(title: "Learn more", subTitle: "Make a deep dive and view even more information about your plants.", imageName: "square.fill.text.grid.1x2")
                    }.padding(.horizontal)
            
            Spacer()
        }
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}



