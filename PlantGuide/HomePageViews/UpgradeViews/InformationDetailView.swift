//
//  InformationDetailView.swift
//  PlantGuide
//
//  Created by (non work) on 07.01.21.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(Color(.label))
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .bold()
                    .foregroundColor(Color(.label))
                    .opacity(0.9)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(Color(.label))
                    .fixedSize(horizontal: false, vertical: true)
            }.multilineTextAlignment(.leading)
            .frame(width: UIScreen.screenWidth * 0.7, alignment: .leading)
        }
        .padding(.top)
    }
}

struct InformationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InformationDetailView()
    }
}
