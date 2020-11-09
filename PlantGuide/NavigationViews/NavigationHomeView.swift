//
//  NavigationHomeView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationHomeView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    var body: some View {        
        NavigationView {
            ZStack{
                VStack {
                    Spacer()
                    switch navigationRouter.currentPage {
                                case .homePage:
                                    Text("home")
                                case .scanPage:
                                    Text("scan")
                                case .overViewPage:
                                    NavigationTestView()
                            }
//                    if navigationSelection == "Overview" {
//                        NavigationTestView()
//                    } else if navigationSelection == "Home" {
//                        
//                        
//                    } else if navigationSelection == "Scan" {
//                        
//                    }
                    
                    Spacer()
                    
                    NavigationBarView()
                }
            }.navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        Text("Plant Room")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .kerning(-2)
                        
                        LogoAsset()
                            .stroke(lineWidth: 5)
                            .frame(width: 35, height: 35)
                            .offset(y: -5)
                        
                        Spacer()
                    }.offset(x: 10, y: 45)
                }
            }
        }
    }
}

struct NavigationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHomeView()
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
    }
}
