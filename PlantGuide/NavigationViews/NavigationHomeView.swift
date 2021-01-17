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
            .onAppear(perform: {DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {checkForUpdate()}})
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
        }.accentColor(Color("textBlue"))
    }
    // I use this to display the onboarding screen
    // Get current Version of the App
    func getCurrentAppVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let version = (appVersion as! String)

        return version
    }

    // Check if app if app has been started after update
    func checkForUpdate() {
        let version = getCurrentAppVersion()
        let savedVersion = UserDefaults.standard.string(forKey: "savedVersion")

        if savedVersion == version {
            print("App was already used")
        } else {
            print("App started the first time")
            // Toogle to show Welcome Screen as Modal
            self.isTutorialVisible.toggle()
            UserDefaults.standard.set(version, forKey: "savedVersion")
        }
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

