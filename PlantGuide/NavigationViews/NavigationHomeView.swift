//
//  NavigationHomeView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI
import CoreData

struct NavigationHomeView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var selectedPlant: SelectedPlant
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var showLearnMoreSheet: Bool = false
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @StateObject var storeManager: StoreManager
    
    @State var onEdit: Bool = false
    @State var seeAll: Bool = false
    @State var isAboutVisible: Bool = false
    @State var showUpgradeView = false
    @State var isTutorialVisible = false
    @State var isSettingsVisible = false
    
//    init() {
//            // this is not the same as manipulating the proxy directly
//            let appearance = UINavigationBarAppearance()
//            // this overrides everything you have set up earlier.
//            appearance.configureWithTransparentBackground()
//
//            // this only applies to big titles
//            appearance.largeTitleTextAttributes = [
//                .font : UIFont.systemFont(ofSize: 35, weight: .bold),
//                NSAttributedString.Key.kern: -2
//            ]
//            // this only applies to small titles
//            appearance.titleTextAttributes = [
//                .font : UIFont.systemFont(ofSize: 35, weight: .bold),
//                NSAttributedString.Key.kern: -2
//
//            ]
//
//            //In the following two lines you make sure that you apply the style for good
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//            UINavigationBar.appearance().standardAppearance = appearance
//
//        }
    
    var body: some View {        
        NavigationView {
            
            ZStack {
                
                VStack {
                    switch navigationRouter.currentPage {
                                case .homePage:
                                    NavigationListView(onEdit: $onEdit, seeAll: $seeAll, showUpgradeView: $showUpgradeView, storeManager: storeManager)
                                        
                                case .scanPage:
                                    NavigationScanView(plantID: Binding.constant("scan"), imagePath: Binding.constant(""))
                                    
                                case .overViewPage:
                                    NavigationOverviewView(showLearnMoreSheet: $showLearnMoreSheet)
                    }
                    
                    Spacer()
                    
                    NavigationBarView()
                }
                
                
                
            }
            .overlay(WelcomeView(isTutorialVisible: $isTutorialVisible))
            .overlay(AboutView(isAboutVisible: $isAboutVisible))
            .overlay(SettingsView(isSettingsVisible: $isSettingsVisible))
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    switch navigationRouter.currentPage {
                                case .homePage:
                                    NavigationBarTitleView(title: "Home")
                                case .scanPage:
                                    NavigationBarTitleView(title: "Scan")
                                case .overViewPage:
                                    NavigationBarTitleView(title: "Overview")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle("")
            .navigationBarItems(trailing: NavigationHeaderBar(isAboutVisible: $isAboutVisible, isTutorialVisible: $isTutorialVisible, isSettingsVisible: $isSettingsVisible))
        }.accentColor(Color("welcomeBlue"))
    }
}

struct NavigationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHomeView(storeManager: StoreManager())
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

