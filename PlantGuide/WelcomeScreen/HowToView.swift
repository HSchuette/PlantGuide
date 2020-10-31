//
//  HowToView.swift
//  PlantGuide
//
//  Created by (non work) on 31.10.20.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack {
            
            Spacer()
        
            Text("Welcome to Plant Room!")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .kerning(-2)
                .foregroundColor(Color(.white))
            
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


struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(Color(.white))
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .foregroundColor(Color(.white))
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}
