//
//  UpgradeView.swift
//  PlantGuide
//
//  Created by (non work) on 29.12.20.
//

import SwiftUI
import StoreKit

struct UpgradeView: View {
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    NavigationBarTitleView(title: "Upgrade")
                        .offset(y: -30)
                        .padding(25)
                    
                    VStack {
                        Rectangle()
                            .fill(Color(.systemGray4))
                            .cornerRadius(2)
                            .frame(width: 50, height: 5)
                            .padding(10)
                        
                        Spacer()
                    }
                    
                }.frame(height: 100)
                
                Spacer()
                
                List(storeManager.myProducts, id: \.self) { product in
                    if UserDefaults.standard.bool(forKey: "com.example.PlantGuide.IAP.plantRoomPlus") {
                            Text("Thank your for your purchase")
                                .foregroundColor(.green)
                        } else {
                            Button(action: {
                                storeManager.purchaseProduct(product: product)
                            }) {
                                Text("Buy for \(product.price) $")
                            }.foregroundColor(.blue)
                        }
                }
                
                Button(action: {
                    storeManager.restoreProducts()
                }) {
                    Text ("Restore Purchases")
                }
                
                Spacer()
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.onAppear(perform: {
            SKPaymentQueue.default().add(storeManager)
            storeManager.getProducts(productIDs: ["com.example.PlantGuide.IAP.plantRoomPlus"])
        })
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeView(storeManager: StoreManager())
    }
}
