//
//  CardCarousselToppingView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI
import CoreData

struct CardCarousselToppingView: View {
    
    @StateObject var storeManager: StoreManager
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)

    private var storePlants: FetchedResults<StorePlantEntity>
    
    @Binding var onEdit: Bool
    @Binding var seeAll: Bool
    @Binding var showUpgradeView: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Your Plant Gallery")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if storePlants.count >= 3 && !UserDefaults.standard.bool(forKey: "com.example.PlantGuide.IAP.plantRoomPlus") {
                    Button(action: {
                        print("buy botton clicked")
                        showUpgradeView.toggle()
                        
                    }, label: {
                        HStack {
                            Text("Add more")
                                .font(.subheadline)
                            
                            Image(systemName: "plus.circle")
                                .font(.subheadline)
                        }
                        
                    })
                } else {
                    CardCarousselAddMoreButton()
                }
                
            }.padding(.bottom, 5)
            
            
            Divider()
            
            HStack {
                
                CardCarousselOnEditButton(onEdit: $onEdit)
                
                Spacer()
                if self.storePlants.count < 3 {
                } else {
                    CardCarousselSeeAllButton(seeAll: $seeAll)
                }
            }.sheet(isPresented: $showUpgradeView, content: {
                UpgradeView(storeManager: storeManager, isLimitReached: storePlants.count == 5)
            })
            
        }.padding(.horizontal, 25)
        .accentColor(Color("textBlue"))
    }
}

struct CardCarousselToppingView_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselToppingView(storeManager: StoreManager(), onEdit: Binding.constant(false), seeAll: Binding.constant(false), showUpgradeView: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
