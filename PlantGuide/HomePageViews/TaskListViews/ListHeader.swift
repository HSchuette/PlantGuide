//
//  ListHeader.swift
//  PlantGuide
//
//  Created by (non work) on 21.11.20.
//

import SwiftUI

struct ListHeader: View {
    var text: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .font(.subheadline)
                
                Text(text)
                    .font(.subheadline)
                
                Spacer()
            }
            .opacity(0.5)
            .padding(.bottom)
            .padding(.top, 5)
        }
    }
}


struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(text: "TODAY", imageName: "calendar")
    }
}
