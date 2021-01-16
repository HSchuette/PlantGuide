//
//  UpgradeView.swift
//  PlantGuide
//
//  Created by (non work) on 29.12.20.
//

import SwiftUI
import StoreKit

struct UpgradeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var storeManager: StoreManager
    
    var isLimitReached: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                       
                Image("watering_plant_isometric")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Spacer()
                
                if isLimitReached == true {
                    VStack(alignment: .leading) {
                        Text("Thank you for using Plant Room!")
                            .bold()
                            .padding(.bottom, 5)
                        
                        Text("You have reached your limit of 3 plants. Feel free to upgrade to add more.")
                            
                    }.padding(.horizontal, 20)
                }
                
                Group {
                    HStack {
                        Text("Features")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .kerning(-1)
                            .foregroundColor(Color(.label))
                            .padding(.leading)
                        
                        Spacer()
                    }.padding([.leading, .top])
                    
                    InformationDetailView(title: "Unlimited Access", subTitle: "Add every plant you want to your Plant Room.", imageName: "calendar.badge.plus")
                    
                    InformationDetailView(title: "Custom App Icon", subTitle: "Change the App Icon to the logo you like.", imageName: "apps.iphone")
                    
                    InformationDetailView(title: "Support", subTitle: "Get new features first and support the developement.", imageName: "heart.text.square")
                }
                
                Spacer()
                
                ForEach(storeManager.myProducts, id: \.self) { product in
                    if UserDefaults.standard.bool(forKey: "com.example.PlantGuide.IAP.plantRoomPlus") {
                            Text("Thank your for your purchase")
                                .foregroundColor(.green)
                        } else {
                            if product.productIdentifier == "com.example.PlantGuide.IAP.plantRoomPlus" {
                                Button(action: {
                                    storeManager.purchaseProduct(product: product)
                                }, label: {
                                    
    //                                    Text("Buy for 1,99 $")
                                        Text("Buy for \(product.localizedPrice)")
                                })
                                .buttonStyle(CustomButtonStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                                )
                            }
                        }
                }
                
                Button(action: {
                    storeManager.restoreProducts()
                }) {
                    Text ("Restore Purchases")
                }.padding()
                               
                
                
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.onAppear(
            perform: {
                if storeManager.myProducts.contains(where: { $0.productIdentifier == "com.example.PlantGuide.IAP.plantRoomPlus"}) {
                    
                } else {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: ["com.example.PlantGuide.IAP.plantRoomPlus"])
                }
            })
        .accentColor(Color("textBlue"))
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeView(storeManager: StoreManager(), isLimitReached: true)
    }
}
