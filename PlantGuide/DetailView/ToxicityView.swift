//
//  ToxicityView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct ToxicityView: View {
    
    @Binding var selected: Int?
    @Binding var moreInfo: String?
    
    var teal = Color(red: 57/256, green: 100/256, blue: 94/256)
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: teal, image: "exclamationmark.triangle.fill")
                    .padding(.trailing, 5)
                
                Text("Toxicity")
                    .bold()
                    .padding()
            
                Spacer()
            }
            
            if self.moreInfo == "moreToxicity" {
                VStack(alignment: .leading) {
                    Text(plantData[selected!].toxicityText)
                     .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct ToxicityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToxicityView(selected: Binding.constant(2), moreInfo: Binding.constant(nil))
            ToxicityView(selected: Binding.constant(2), moreInfo: Binding.constant("moreToxicity"))
        }
    }
}
