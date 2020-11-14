//
//  CardCarousselToppingView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI
import CoreData

struct CardCarousselToppingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @Binding var onEdit: Bool
    @Binding var seeAll: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Your Plant Gallery")
                    .font(.callout)
                    .fontWeight(.medium)
                
                Spacer()
                
                CardCarousselAddMoreButton()
                
            }.padding(.bottom, 5)
            
            Divider()
            
            HStack {
                
                CardCarousselOnEditButton(onEdit: $onEdit)
                
                Spacer()
                if self.storePlants.count < 3 {
                } else {
                    CardCarousselSeeAllButton(seeAll: $seeAll)
                }
            }
            
        }.padding(.horizontal, 25)
    }
}

struct CardCarousselToppingView_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselToppingView(onEdit: Binding.constant(false), seeAll: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
