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
        HStack {
            Image(systemName: imageName)
            
            Text(text)
        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding(UITableView().separatorInset.left)
        .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
        .background(Color(.systemBackground))
    }
}


struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(text: "TODAY", imageName: "calendar")
    }
}
