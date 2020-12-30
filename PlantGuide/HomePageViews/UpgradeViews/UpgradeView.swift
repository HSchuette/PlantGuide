//
//  UpgradeView.swift
//  PlantGuide
//
//  Created by (non work) on 29.12.20.
//

import SwiftUI

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
                
                if UserDefaults.standard.bool(forKey: "*ID of IAP Product*") {
                        Text("Thank your for your purchase")
                            .foregroundColor(.green)
                    } else {
                        Button(action: {
                            //Purchase particular IAO product
                        }) {
                            Text("Buy for 1.09 $")
                        }
                            .foregroundColor(.blue)
                    }
                
                Spacer()
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeView(storeManager: StoreManager())
    }
}
